terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.58.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.6.0"
    }
  }
}
