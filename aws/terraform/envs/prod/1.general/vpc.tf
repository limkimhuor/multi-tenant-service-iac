###################
# Create VPC and only one Nat Gateway for all AZs
###################
module "vpc" {
  source = "../../../../modules/vpc"
  #basic
  env     = var.env
  project = var.project
  region  = var.region

  #vpc
  vpc_cidr      = var.vpc_cidr
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs

  only_one_nat_gateway = true
}

# Additional Database Subnets - Ensures physical network isolation for DB
resource "aws_subnet" "database" {
  count             = length(var.db_cidrs)
  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.db_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project}-${var.env}-db-subnet-${count.index + 1}"
    Type = "database"
  }
}

# Group DB subnets for RDS/Aurora usage
resource "aws_db_subnet_group" "main" {
  name       = "${var.project}-${var.env}-db-subnet-group"
  subnet_ids = aws_subnet.database[*].id

  tags = {
    Name = "${var.project}-${var.env}-db-subnet-group"
  }
}
