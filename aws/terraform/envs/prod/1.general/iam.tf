# ECS Task Execution Role (used by ECS Fargate to pull images, write logs, etc)
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project}-${var.env}-ecs-task-execution-role"

  assume_role_policy = data.aws_iam_policy_document.assume_role_ecs_task_execution.json

  tags = {
    Service = "ecs"
    Name    = "${var.project}-${var.env}-ecs-task-execution-role"
  }
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_iam_role_policy" "ecs_task_execution_custom" {
  name = "${var.project}-${var.env}-ecs-task-execution-custom"
  role = aws_iam_role.ecs_task_execution_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect : "Allow"
        Action : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource : "*"
      },
      {
        Effect : "Allow"
        Action : [
          "kms:Decrypt"
        ]
        Resource : "*"
      }
    ]
  })
}

# ECS Task Role (app container can access Secrets Manager, CloudWatch, etc)
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.project}-${var.env}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_ecs_task.json

  tags = {
    Service = "ecs"
    Name    = "${var.project}-${var.env}-ecs-task-role"
  }
}
resource "aws_iam_role_policy" "ecs_task_custom" {
  name = "${var.project}-${var.env}-ecs-task-custom"
  role = aws_iam_role.ecs_task_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect : "Allow"
        Action : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource : "*"
      },
      {
        Effect : "Allow"
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource : "*"
      },
      {
        Effect : "Allow"
        Action : [
          "cloudwatch:PutMetricData"
        ]
        Resource : "*"
      },
      {
        Effect : "Allow"
        Action : [
          "ecs:DescribeTasks",
          "ecs:DescribeServices",
          "ecs:DescribeClusters"
        ]
        Resource : "*"
      }
    ]
  })
}
