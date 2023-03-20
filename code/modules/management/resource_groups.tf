resource "azurerm_resource_group" "management_rg" {
  name     = "${local.root_id}-mgmt-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "export_rg" {
  name     = "${local.root_id}-export-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "cmk_rg" {
  name     = "${local.root_id}-cmk-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "plcy_rg" {
  name     = "${local.root_id}-plcy-rg"
  location = var.location
  tags     = var.tags
}
