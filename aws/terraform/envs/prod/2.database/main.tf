# # Aurora PostgreSQL cluster parameter group
# resource "aws_rds_cluster_parameter_group" "aurora_postgres" {
#   name   = "${var.project}-${var.env}-aurora-postgres-pg"
#   family = "aurora-postgresql15"

#   parameter {
#     apply_method = "pending-reboot"
#     name  = "max_connections"
#     value = "500"
#   }

#   tags = {
#     Name = "${var.project}-${var.env}-aurora-postgres-pg"
#   }
# }

# # Create a random password for Aurora master user
# resource "random_password" "aurora_master_password" {
#   length  = 32
#   special = true
# }

# # Aurora Serverless v2 (Express) PostgreSQL cluster
# resource "aws_rds_cluster" "aurora" {
#   cluster_identifier              = "${var.project}-${var.env}-aurora"
#   engine                          = "aurora-postgresql"
#   engine_mode                     = "provisioned" # Required for Aurora Serverless v2 (Express)
#   engine_version                  = "15.3"
#   database_name                   = "${var.project}-${var.env}"
#   master_username                 = "mtAdmin"
#   master_password                 = random_password.aurora_master_password.result
#   backup_retention_period         = var.aurora_backup_retention
#   preferred_backup_window         = "03:00-04:00"
#   preferred_maintenance_window    = "sun:04:00-sun:05:00"
#   db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_postgres.name
#   db_subnet_group_name            = data.terraform_remote_state.general.outputs.db_subnet_group_name
#   vpc_security_group_ids          = [data.terraform_remote_state.general.outputs.database_security_group_id]
#   storage_encrypted               = true
#   skip_final_snapshot             = false

#   # Required for Aurora Serverless v2 (Express)
#   serverlessv2_scaling_configuration {
#     min_capacity = var.aurora_min_capacity
#     max_capacity = var.aurora_max_capacity
#   }
#   enable_http_endpoint = true

#   tags = {
#     Name = "${var.project}-${var.env}-aurora-postgresql"
#   }
# }

# # Aurora PostgreSQL cluster instances
# resource "aws_rds_cluster_instance" "aurora" {
#   count                = var.aurora_instances
#   identifier           = "${var.project}-${var.env}-aurora-${count.index + 1}"
#   cluster_identifier   = aws_rds_cluster.aurora.id
#   instance_class       = var.aurora_instance_class
#   engine               = aws_rds_cluster.aurora.engine
#   engine_version       = aws_rds_cluster.aurora.engine_version

#   tags = {
#     Name = "${var.project}-${var.env}-aurora-postgresql-instance-${count.index + 1}"
#   }
# }

# # Store Aurora master credentials in AWS Secrets Manager
# resource "aws_secretsmanager_secret" "aurora_credentials" {
#   name        = "${var.project}-${var.env}/aurora/master"
#   description = "Aurora master credentials"
#   tags = {
#     Name = "${var.project}-${var.env}-aurora-secrets"
#   }
# }
# resource "aws_secretsmanager_secret_version" "aurora_credentials_version" {
#   secret_id = aws_secretsmanager_secret.aurora_credentials.id
#   secret_string = jsonencode({
#     username = "mtAdmin"
#     password = random_password.aurora_master_password.result
#     engine   = "postgres"
#     host     = aws_rds_cluster.aurora.endpoint
#     port     = 5432
#     dbname   = aws_rds_cluster.aurora.database_name
#     url      = "postgresql://mtAdmin:${random_password.aurora_master_password.result}@${aws_rds_cluster.aurora.endpoint}:5432/${aws_rds_cluster.aurora.database_name}"
#   })
# }

# Generate master password
resource "random_password" "rds_master_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# RDS PostgreSQL instance - Free Tier eligible
resource "aws_db_instance" "postgres" {
  identifier              = "${var.project}-${var.env}-postgres"
  engine                  = "postgres"
  engine_version          = "15"
  instance_class          = "db.t3.micro" # Free Tier eligible
  allocated_storage       = 20            # Free Tier eligible: up to 20GB
  db_name                 = "db${var.env}"
  username                = "root"
  password                = random_password.rds_master_password.result
  storage_type            = "gp2"
  vpc_security_group_ids  = [data.terraform_remote_state.general.outputs.database_security_group_id]
  db_subnet_group_name    = data.terraform_remote_state.general.outputs.db_subnet_group_name
  backup_retention_period = 1
  skip_final_snapshot     = true
  multi_az                = false # Free Tier does not support Multi-AZ

  tags = {
    Name = "${var.project}-${var.env}-rds-postgres"
  }
}

# Store PostgreSQL credentials in AWS Secrets Manager
resource "aws_secretsmanager_secret" "postgres_credentials" {
  name        = "${var.project}-${var.env}/postgres/master"
  description = "RDS PostgreSQL master credentials"

  tags = {
    Name = "${var.project}-${var.env}-postgres-secrets"
  }
}

resource "aws_secretsmanager_secret_version" "postgres_credentials_version" {
  secret_id = aws_secretsmanager_secret.postgres_credentials.id
  secret_string = jsonencode({
    username = "root"
    password = random_password.rds_master_password.result
    engine   = "postgres"
    host     = aws_db_instance.postgres.address
    port     = 5432
    dbname   = aws_db_instance.postgres.db_name
    url      = "postgresql://root:${random_password.rds_master_password.result}@${aws_db_instance.postgres.address}:5432/${aws_db_instance.postgres.db_name}"
  })
}
