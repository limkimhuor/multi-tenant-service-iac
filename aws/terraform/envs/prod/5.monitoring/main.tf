resource "aws_sns_topic" "alarm_topic" {
  count = var.alarm_email != "" ? 1 : 0
  name  = "${var.project}-${var.env}-app-alarm-topic"
  tags = {
    Project     = var.project
    Environment = var.env
    ManagedBy   = "terraform"
  }
}

resource "aws_sns_topic_subscription" "alarm_subscription" {
  count     = var.alarm_email != "" ? 1 : 0
  topic_arn = aws_sns_topic.alarm_topic[0].arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.project}-${var.env}-app"
  retention_in_days = var.cw_log_retention_in_days

  tags = {
    ManagedBy = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "app_500_errors" {
  alarm_name          = "${var.project}-${var.env}-app-high-500-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "5XXError"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 10
  alarm_description   = "High rate of 5XX errors detected on Application ELB"
  dimensions = {
    LoadBalancer = data.terraform_remote_state.application.outputs.app_alb_name
  }
  actions_enabled = var.alarm_email != ""
  alarm_actions   = var.alarm_email != "" ? [aws_sns_topic.alarm_topic[0].arn] : []

  tags = {
    ManagedBy = "terraform"
  }
}
