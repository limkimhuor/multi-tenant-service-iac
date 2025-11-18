# ECS Cluster Outputs
output "ecs_cluster_id" {
  value       = aws_ecs_cluster.main.id
  description = "ECS Cluster ID"
}
output "ecs_cluster_arn" {
  value       = aws_ecs_cluster.main.arn
  description = "ECS Cluster ARN"
}
output "ecs_cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "ECS Cluster Name"
}

# CloudWatch Log Group Outputs
output "ecs_log_group_name" {
  value       = aws_cloudwatch_log_group.app.name
  description = "CloudWatch Log Group Name for application logs"
}

# ALB Outputs
output "alb_arn" {
  value       = aws_lb.main.arn
  description = "ARN of the Application Load Balancer"
}
output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "DNS name of the Application Load Balancer"
}
output "alb_zone_id" {
  value       = aws_lb.main.zone_id
  description = "Zone ID of the Application Load Balancer"
}
output "alb_arn_suffix" {
  value       = aws_lb.main.arn_suffix
  description = "ARN suffix for CloudWatch metrics"
}
output "app_target_group_arn" {
  value       = aws_lb_target_group.app.arn
  description = "ARN of Rails application target group"
}
output "https_listener_arn" {
  value       = aws_lb_listener.https.arn
  description = "ARN of HTTPS listener"
}

# SSL Certificate
output "ssl_certificate_arn" {
  value       = "arn:aws:acm:ap-northeast-1:098131748091:certificate/d40d8f36-3a00-4098-b9af-22ebee5d3780" # aws_acm_certificate_validation.main.certificate_arn
  description = "ARN of validated SSL certificate"
}

# Route 53
output "route53_zone_id" {
  value       = aws_route53_zone.main.zone_id
  description = "Route 53 hosted zone ID"
}
output "route53_zone_name_servers" {
  value       = aws_route53_zone.main.name_servers
  description = "Route 53 name servers"
}
