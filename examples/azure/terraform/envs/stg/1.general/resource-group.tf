###################
# Create resource-group
###################
module "resource_group" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/resource-group?ref=terraform-azure-resource-group_v0.0.2"

  #basic
  env      = var.env
  project  = var.project
  location = var.location

  tags = local.default_tags
}
