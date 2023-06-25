terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.62.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.7.0"
    }
  }
}
