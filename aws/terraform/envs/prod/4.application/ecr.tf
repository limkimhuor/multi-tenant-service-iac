# Application Secrets
resource "aws_secretsmanager_secret" "app_secrets" {
  name        = "${var.project}-${var.env}/app"
  description = "Secrets for Rails application"
  kms_key_id  = "alias/multi-tenant-service-iac-prod-iac"

  tags = {
    Name = "${var.project}-${var.env}-app-secrets"
  }
}
resource "random_password" "secret_key_base" {
  length  = 64
  special = true
}
resource "aws_secretsmanager_secret_version" "app_secrets_version" {
  secret_id = aws_secretsmanager_secret.app_secrets.id
  secret_string = jsonencode({
    secret_key_base = random_password.secret_key_base.result
  })
}

resource "aws_ecr_repository" "app" {
  name = "${var.project}-${var.env}-app"

  # Prevent tag overwriting for security and compliance
  image_tag_mutability = "MUTABLE"

  # Enable image scanning on push for security
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.project}-${var.env}-app"
  }
}

# Lifecycle policy to keep only recent images
resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 5 images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 5
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Delete untagged images after 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

# ECR Repository Policy - Allow pull from ECS execution role
resource "aws_ecr_repository_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowECSTaskExecutionRolePull"
        Effect = "Allow"
        Principal = {
          AWS = data.terraform_remote_state.general.outputs.ecs_task_execution_role_arn
        }
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project}-${var.env}-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
  execution_role_arn       = data.terraform_remote_state.general.outputs.ecs_task_execution_role_arn
  task_role_arn            = data.terraform_remote_state.general.outputs.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "${aws_ecr_repository.app.repository_url}:latest"
      cpu       = var.app_cpu
      memory    = var.app_memory
      essential = true
      portMappings = [
        {
          containerPort = var.app_container_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = data.terraform_remote_state.compute.outputs.ecs_log_group_name
          "awslogs-region"        = var.region
          "awslogs-stream-prefix" = "ecs"
        }
      }
      environment = [
        { name = "RAILS_ENV", value = var.env },
        { name = "PROJECT", value = var.project },
        { name = "APP_DOMAIN", value = var.domain_name }
      ]
      secrets = [
        {
          name      = "DATABASE_URL"
          valueFrom = data.terraform_remote_state.database.outputs.rds_url
        },
        {
          name      = "SECRET_KEY_BASE"
          valueFrom = aws_secretsmanager_secret_version.app_secrets_version.secret_string
        }
      ]
      essential = true
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:3000/health || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      }
    }
  ])

  tags = {
    Name = "${var.project}-${var.env}-app-task"
  }
}

resource "aws_ecs_service" "app" {
  name            = "${var.project}-${var.env}-app"
  cluster         = data.terraform_remote_state.compute.outputs.ecs_cluster_id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.terraform_remote_state.general.outputs.private_subnet_ids
    security_groups  = [data.terraform_remote_state.general.outputs.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:098131748091:loadbalancer/app/app-prod-alb/2cec533d7247571e" #aws_lb_target_group.app.arn
    container_name   = "app"
    container_port   = var.app_container_port
  }

  deployment_controller {
    type = "ECS"
  }

  tags = {
    Name = "${var.project}-${var.env}-app-service"
  }
}
