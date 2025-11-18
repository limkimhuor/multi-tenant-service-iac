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

# Application Layer variables
variable "app_desired_count" {
  type = number
}
variable "app_cpu" {
  type = number
}
variable "app_memory" {
  type = number
}
variable "app_container_port" {
  type = number
}

# Monitoring variables
variable "cw_log_retention_in_days" {
  type    = number
  default = 30
}
variable "alarm_email" {
  type    = string
  default = "kimhuorlim@gmail.com"
}
