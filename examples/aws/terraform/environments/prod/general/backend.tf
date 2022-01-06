###################
# General Initialization
###################
terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37"
    }
    template = "~> 2.0"
  }
  backend "s3" {
    profile        = "project-prod"
    bucket         = "project-iac-state-prod"
    key            = "general/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:<account-id>:key/<key-id>"
    dynamodb_table = "project-terraform-state-lock-prod"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "${var.project}-${var.env}"
}
data "aws_caller_identity" "current" {}
