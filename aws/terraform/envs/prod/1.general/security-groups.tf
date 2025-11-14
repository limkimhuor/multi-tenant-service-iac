resource "aws_security_group" "alb" {
  name_prefix = "${var.project}-${var.env}-alb-"
  vpc_id      = module.vpc.vpc_id
  description = "ALB security group"

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.project}-${var.env}-alb-sg"
    Layer = "network"
  }
}

resource "aws_security_group" "ecs" {
  name_prefix = "${var.project}-${var.env}-ecs-"
  vpc_id      = module.vpc.vpc_id
  description = "ECS security group"

  ingress {
    description     = "Allow HTTP from ALB"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.project}-${var.env}-ecs-sg"
    Layer = "compute"
  }
}

resource "aws_security_group" "database" {
  name_prefix = "${var.project}-${var.env}-db-"
  vpc_id      = module.vpc.vpc_id
  description = "Database security group"

  ingress {
    description     = "Allow PostgreSQL from ECS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }
  tags = {
    Name  = "${var.project}-${var.env}-db-sg"
    Layer = "database"
  }
}

resource "aws_security_group" "cache" {
  name_prefix = "${var.project}-${var.env}-cache-"
  vpc_id      = module.vpc.vpc_id
  description = "Redis cache security group"

  ingress {
    description     = "Allow Redis from ECS"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }
  tags = {
    Name  = "${var.project}-${var.env}-cache-sg"
    Layer = "data"
  }
}
