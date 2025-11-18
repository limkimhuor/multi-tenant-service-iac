project = "multi-tenant-service-iac"
env     = "prod"
region  = "ap-northeast-1"

# VPC Configuration
vpc_cidr = "10.0.0.0/16"

# Subnets Configuration
public_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
db_cidrs      = ["10.0.21.0/24", "10.0.22.0/24"]

# Aurora PostgreSQL settings - Not support free-tier
# aurora_instance_class    = "db.serverless"
# aurora_min_capacity      = 0.5
# aurora_max_capacity      = 1
# aurora_backup_retention  = 7 # Backup retention period in days
# aurora_instances         = 2 # Number of Aurora instances (at least 2 for High Availability)

# Domain Configuration
domain_name = "huorlk.uk"

# ECS Configuration
ecs_cluster_name  = "multi-tenant-service-iac-prod-ecs-cluster"
ecs_cpu           = 1024
ecs_memory        = 2048
ecs_desired_count = 2
ecs_max_capacity  = 10

# Application Layer (ECS Service/Task/Application specific)
app_desired_count  = 2
app_cpu            = 512
app_memory         = 1024
app_container_port = 3000
