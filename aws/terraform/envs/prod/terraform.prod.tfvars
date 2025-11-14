project = "multi-tenant-service-iac"
env     = "prod"
region  = "ap-northeast-1"

# VPC Configuration
vpc_cidr = "10.0.0.0/16"

# Subnets Configuration
public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
db_cidrs      = ["10.0.21.0/24", "10.0.22.0/24"]
