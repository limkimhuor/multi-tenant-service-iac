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
