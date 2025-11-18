# Data sources
data "aws_region" "current" {}

data "terraform_remote_state" "general" {
  backend = "s3"
  config = {
    profile = "${var.project}-${var.env}"
    bucket  = "${var.project}-${var.env}-iac-state"
    key     = "general/terraform.${var.env}.tfstate"
    region  = var.region
  }
}

data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    profile = "${var.project}-${var.env}"
    bucket  = "${var.project}-${var.env}-iac-state"
    key     = "compute/terraform.${var.env}.tfstate"
    region  = var.region
  }
}

data "terraform_remote_state" "database" {
  backend = "s3"
  config = {
    profile = "${var.project}-${var.env}"
    bucket  = "${var.project}-${var.env}-iac-state"
    key     = "database/terraform.${var.env}.tfstate"
    region  = var.region
  }
}

# Get AWS Load Balancer service account for access logs
data "aws_elb_service_account" "main" {}

locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = data.aws_region.current.id
}
