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
