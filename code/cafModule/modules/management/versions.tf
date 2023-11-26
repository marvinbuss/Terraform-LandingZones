terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.82.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.8.0"
    }
  }
}
