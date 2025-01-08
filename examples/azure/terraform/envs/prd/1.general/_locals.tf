locals {
  default_tags = {
    environment = var.full_env
    project     = var.project
    iac         = "terraform"
    iac_service = "general"
  }
}
