resource "azurerm_user_assigned_identity" "user_assigned_identity_cmk" {
  name                = "${local.root_id}-cmk-id"
  location            = var.location
  resource_group_name = azurerm_resource_group.cmk_rg.name
  tags                = var.tags
}

resource "azurerm_user_assigned_identity" "user_assigned_identity_policy" {
  name                = "${local.root_id}-plcy-id"
  location            = var.location
  resource_group_name = azurerm_resource_group.plcy_rg.name
  tags                = var.tags
}
