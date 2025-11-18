# ECR Outputs
output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.app.repository_url
}
output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.app.arn
}
output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.app.name
}

# Application ECS Service Outputs
output "app_service_name" {
  value       = aws_ecs_service.app.name
  description = "ECS Service name for the application"
}
output "app_service_arn" {
  value       = aws_ecs_service.app.arn
  description = "ARN of the ECS Service"
}
output "app_task_definition_arn" {
  value       = aws_ecs_task_definition.app.arn
  description = "ARN of the ECS task definition"
}

# Application Secrets
output "secret_key_base" {
  value       = aws_secretsmanager_secret_version.app_secrets_version.secret_string
  description = "Secret key base for Rails production"
  sensitive   = true
}
output "secret_manager_arn" {
  value       = aws_secretsmanager_secret.app_secrets.arn
  description = "ARN for secret manager to use from ECS"
}
