#!/bin/bash

echo "Please Input Project Name:"
read project
echo "Please Input ENV (dev/stg/prd):"
read env
echo "Please Input Location:"
read location

# Define env
state="iacstate"
resource_group_name="$project-$env-iac-rg"
cloudshell_storage_account_name=$(echo "${project}${env}cloudshell" | tr -d '-' | tr '[:upper:]' '[:lower:]')
iac_storage_account_name=$(echo "${project}${env}${state}" | tr -d '-' | tr '[:upper:]' '[:lower:]')

# Define subscription names
subscription_dev="xxx"
subscription_stg="xxx"
subscription_prd="xxx"

# Set subscription based on the environment
if [ "$env" == "dev" ]; then
    az account set --subscription "$subscription_dev"
elif [ "$env" == "stg" ]; then
    az account set --subscription "$subscription_stg"
elif [ "$env" == "prd" ]; then
    az account set --subscription "$subscription_prd"
else
    echo "Invalid environment: $env"
    exit 1
fi

# Create Resource Group
az group create --name $resource_group_name --location $location

# Create storage account iac state
# Print the storage account name for Cloud Shell
echo "Cloud Shell Storage Account Name: $cloudshell_storage_account_name"
az storage account create --resource-group $resource_group_name --name $iac_storage_account_name --sku Standard_LRS --encryption-services blob

# Get storage account key iac state
ACCOUNT_KEY=$(az storage account keys list --resource-group $resource_group_name --account-name $iac_storage_account_name --query [0].value -o tsv)

# Create blob container iac state
az storage container create --name $state --account-name $iac_storage_account_name --account-key $ACCOUNT_KEY

# Create Key vaults
# https://github.com/getsops/sops?tab=readme-ov-file#24encrypting-using-azure-key-vault
az keyvault create --name $project-$env-iac --resource-group $resource_group_name --location $location
az keyvault key create --name $project-$env-iac-key --vault-name $project-$env-iac --protection software --ops encrypt decrypt
az keyvault set-policy --name $project-$env-iac --resource-group $resource_group_name --spn $AZURE_CLIENT_ID --key-permissions encrypt decrypt
az keyvault key show --name $project-$env-iac-key --vault-name $project-$env-iac --query key.kid
