project         = "project"
env             = "prd"
full_env        = "production"
location        = "japaneast" #"Japan East"
subscription_id = "26d8766f-b26f-4bc8-9f0c-d026d2a843da"
domain          = "vaan.eragon123app.com"

global_ips = {
  sun_hni_office = ["1.1.1.1/32", "2.2.2.2/32", "3.3.3.3/32"]
  sun_hni_office = ["1.1.1.1/32", "2.2.2.2/32", "3.3.3.3/32"]
  sun_hcm        = ["4.4.4.4/32", "5.5.5.5/32"]
  sun_jp         = ["6.6.6.6/32"]
}

vnet = {
  vnet_cidr = "10.15.10.0/26"
  subnet_configuration = {
    app = {
      cidr              = "10.15.10.0/27"
      service_endpoints = ["Microsoft.Sql", "Microsoft.ContainerRegistry"]
      delegations = [
        {
          name = "container-app"
          service_delegation = {
            name    = "Microsoft.App/environments"
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
          }
        }
      ]
    }
    web = {
      cidr              = "10.15.10.32/29"
      service_endpoints = ["Microsoft.Storage"]
    }
  }
}

web = {
  content = {
    name = "azureexampleweb"
    blob = {
      account_replication_type = "ZRS"
      account_tier             = "Standard"
    }
  }
}
