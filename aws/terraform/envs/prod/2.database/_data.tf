# Data sources
data "aws_region" "current" {}

# References outputs from the 1.general layer for networking/security, and optionally Secrets.
data "terraform_remote_state" "general" {
  backend = "s3"
  config = {
    profile = "${var.project}-${var.env}"
    bucket  = "${var.project}-${var.env}-iac-state"
    key     = "general/terraform.${var.env}.tfstate"
    region  = var.region
  }
}

# Fetch current AWS account identity
locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = data.aws_region.current.id
}
