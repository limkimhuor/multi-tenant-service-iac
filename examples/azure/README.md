# Azure

Microsoft Azure, or just Azure. It has management, access and development of applications and services to individuals, companies, and governments through its global infrastructure. It also provides capabilities that are usually not included within other cloud platforms, including software as a service (SaaS), platform as a service (PaaS), and infrastructure as a service (IaaS). Microsoft Azure supports many programming languages, tools, and frameworks, including Microsoft-specific and third-party software and systems.

**This page describes the IaC of the project, as hosted in [Microsoft Azure](https://azure.microsoft.com/)**

## Install & Config tools

### 1. Install on LocalStation

- **azure-cli**

azure-cli is a package provides a unified command line interface to Microsoft Azure.

Refer how to install [azure-cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) base on your OS.

### 2. Config

#### 2.1 Login Azure cli [Get started](https://learn.microsoft.com/en-us/cli/azure/get-started-with-azure-cli)

- Terraform/AZURE-CLI will use this to create Azure infrastructure and excute any command line for using Azure

###### 2.1.1 [Use azure account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli#logging-into-the-azure-cli)
- Sign in with az login.
  ```bash
  az login
  ```
- Sign in on an other device
  ```bash
  az login --use-device-code
  ```
- Setting `_providers.tf`
  ```bash
  # Configure the Microsoft Azure Provider
  provider "azurerm" {
    features {}

    subscription_id = "00000000-0000-0000-0000-000000000000"
    tenant_id       = "11111111-1111-1111-1111-111111111111" #(optional)
  }
  ```

###### 2.1.1 [Use service principal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
- Create the Service Principal:
  ```bash
  az ad sp create-for-rbac --name $project-$env-iac --role="Contributor" --scopes="/subscriptions/20000000-0000-0000-0000-000000000000"

  # The command should output a JSON object similar to this:
  {
    "clientId": "<GUID>",
    "clientSecret": "<STRING>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
    "resourceManagerEndpointUrl": "<URL>"
    (...)
  }
  ```
- Setting `_providers.tf`
  ```bash
  # Configure the Microsoft Azure Provider
  provider "azurerm" {
    features {}

    client_id       = "00000000-0000-0000-0000-000000000000"
    client_secret   = var.client_secret
    tenant_id       = "10000000-0000-0000-0000-000000000000"
    subscription_id = "20000000-0000-0000-0000-000000000000"
  }
  ```
- Store the output of the below az cli command as the value of secret variable, for example 'AZURE_CREDENTIALS'

#### 2.2 (Optional for Terraform) Create manually Azure Resource group, Storage account, to store/lock state and Key vault to encrypt it

- Create Examplpe Azure Storage as a backend

```bash
#!/bin/bash

RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate$RANDOM
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
```

#### Notes: You can use `pre-build.sh` and change value to automatically execute all commands above instead
