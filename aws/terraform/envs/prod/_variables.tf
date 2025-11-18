variable "project" {
  description = "Name of project"
  type        = string
}
variable "env" {
  description = "Name of project environment"
  type        = string
}
variable "region" {
  description = "Region of environment"
  type        = string
}

# VPC variable
variable "vpc_cidr" {
  description = "CIDR of VPC"
  type        = string
}

# Subnets variables
variable "public_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "db_cidrs" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
}

# # Aurora variables
# variable "aurora_instance_class" {
#   description = "Instance class for Aurora instances"
#   type = string
# }
# variable "aurora_min_capacity" {
#   description = "Minimum capacity for Aurora cluster"
#   type = number
# }
# variable "aurora_max_capacity" {
#   description = "Maximum capacity for Aurora cluster"
#   type = number
# }
# variable "aurora_backup_retention" {
#   description = "Backup retention period for Aurora cluster (in days)"
#   type = number
# }
# variable "aurora_instances" {
#   description = "Number of instances in the Aurora cluster"
#   type = number
# }

# Domain variable
variable "domain_name" {
  description = "Domain name"
  type        = string
}

# ECS variables
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}
variable "ecs_cpu" {
  description = "CPU units for the ECS task"
  type        = number
}
variable "ecs_memory" {
  description = "Memory (in MiB) for the ECS task"
  type        = number
}
variable "ecs_desired_count" {
  description = "Desired number of ECS service tasks"
  type        = number
}
variable "ecs_max_capacity" {
  description = "Maximum number of ECS service tasks for auto-scaling"
  type        = number
}
