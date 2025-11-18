###################
# Database Initialization
###################
terraform {
  required_version = ">= 1.3.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    template = "~> 2.0"
  }
  backend "s3" {
    profile        = "multi-tenant-service-iac-prod"
    bucket         = "multi-tenant-service-iac-prod-iac-state"
    key            = "database/terraform.prod.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "alias/multi-tenant-service-iac-prod-iac"
    dynamodb_table = "multi-tenant-service-iac-prod-terraform-state-lock"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "${var.project}-${var.env}"
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.env
      Layer       = "database"
    }
  }
}
data "aws_caller_identity" "current" {}
