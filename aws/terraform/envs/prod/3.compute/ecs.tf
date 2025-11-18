resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name

  # Enable CloudWatch Container Insights for monitoring
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = var.ecs_cluster_name
  }
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.project}-${var.env}/app"
  retention_in_days = 30

  tags = {
    Name = "${var.project}-${var.env}-app-logs"
  }
}
