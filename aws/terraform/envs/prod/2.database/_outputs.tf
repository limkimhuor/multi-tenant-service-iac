# output "aurora_endpoint" {
#   value = aws_rds_cluster.aurora.endpoint
# }

# output "aurora_url" {
#   value = aws_secretsmanager_secret_version.aurora_credentials_version.secret_string
#   sensitive = true
# }

# output "aurora_secret_arn" {
#   value = aws_secretsmanager_secret.aurora_credentials.arn
#   description = "ARN of the Aurora credentials secret"
# }

output "rds_endpoint" {
  description = "RDS PostgreSQL instance endpoint"
  value       = aws_db_instance.postgres.address
}

output "rds_url" {
  description = "Complete connection string (JSON) for RDS PostgreSQL"
  value       = aws_secretsmanager_secret_version.postgres_credentials_version.secret_string
  sensitive   = true
}

output "rds_secret_arn" {
  description = "ARN for the stored master credentials in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.postgres_credentials.arn
}
