output "aws_account_id" {
  value       = <<VALUE

  Check AWS Env:
    Project : "${var.project}" | Env: "${var.env}"
    AWS Account ID: "${data.aws_caller_identity.current.account_id}"
    AWS Account ARN: "${data.aws_caller_identity.current.arn}"
  VALUE
  description = "Show information about project, environment and account"
}

#Output modules
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of VPC"
}

# VPC Subnet Outputs
output "private_subnet_ids" {
  value       = module.vpc.subnet_private_id
  description = "List of private subnet IDs"
}

output "public_subnet_ids" {
  value       = module.vpc.subnet_public_id
  description = "List of public subnet IDs"
}
output "db_subnet_group_name" {
  value       = aws_db_subnet_group.main.name
  description = "The name of the DB subnet group"
}
output "database_subnet_ids" {
  value       = aws_subnet.database[*].id
  description = "List of database subnet IDs"
}

# Security Group Outputs
output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "Security Group ID for Application Load Balancer"
}
output "ecs_security_group_id" {
  value       = aws_security_group.ecs.id
  description = "Security Group ID for ECS tasks and services"
}
output "database_security_group_id" {
  value       = aws_security_group.database.id
  description = "Security Group ID for Database instances"
}
output "cache_security_group_id" {
  value       = aws_security_group.cache.id
  description = "Security Group ID for Cache instances"
}

# IAM Role Outputs
output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "IAM Role ARN for ECS Task Execution Role"
}
output "ecs_task_role_arn" {
  value       = aws_iam_role.ecs_task_role.arn
  description = "IAM Role ARN for ECS Task Role"
}
