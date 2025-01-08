###################
# DNS hostzone
###################
module "dns_zone" {
  source = "git@github.com:framgia/sun-infra-iac.git//modules/dns-zone?ref=terraform-azure-dns-zone_v0.0.1"

  #basic
  resource_group_name = module.resource_group.resource_group_name

  #hostzone
  dns_zone = {
    name = var.domain
  }

  tags = local.default_tags
}
