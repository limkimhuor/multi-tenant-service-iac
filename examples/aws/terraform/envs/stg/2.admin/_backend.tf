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
    profile = "project-stg"
    bucket  = "project-iac-state-stg"
    key     = "admin/terraform.stg.tfstate"
    region  = "ap-northeast-1"
    /* encrypt        = true
    kms_key_id     = "arn:aws:kms:ap-northeast-1:<account-id>:key/<key-id>" */
    dynamodb_table = "project-terraform-state-lock-stg"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = "${var.project}-${var.env}"
}
data "aws_caller_identity" "current" {}


###################
# General State
###################
data "terraform_remote_state" "general" {
  backend = "s3"
  config = {
    profile = "${var.project}-${var.env}"
    bucket  = "${var.project}-iac-state-${var.env}"
    key     = "general/terraform.${var.env}.tfstate"
    region  = var.region
  }
}
