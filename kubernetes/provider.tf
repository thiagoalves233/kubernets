terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.70.0"
    }
  }
   backend "azurerm" {
    resource_group_name  = "rg-br-mateusmais-prod"
    storage_account_name = "mateusmaisterraform"
    container_name       = "tfstate"
    key                  = "cloud/dev-qa-aks.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = "6849eec3-5c1d-4629-acce-eadec66cc18c"
  client_id       = "84d28679-2f09-4464-800a-93d34fde3dda"
  client_secret   = "B1a8Q~ozyMGEUNA3IVIhST2F-RPH3.7L.hI1RbaT"
  tenant_id       = "77f91f97-eeac-4ec0-bff5-a33822b0a029"
}
