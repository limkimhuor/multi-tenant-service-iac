output "cw_log_group_app_name" {
  value       = aws_cloudwatch_log_group.app.name
  description = "Log group name for application logs"
}
output "app_500_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.app_500_errors.arn
  description = "ARN for 5XX error alarm"
}
