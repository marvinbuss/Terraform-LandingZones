terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.53.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.5.0"
    }
  }
}
