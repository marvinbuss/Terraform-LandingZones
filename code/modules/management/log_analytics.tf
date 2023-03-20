resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "${local.root_id}-la"
  location            = var.location
  resource_group_name = azurerm_resource_group.management_rg.name
  tags                = var.tags

  allow_resource_only_permissions = true
  cmk_for_query_forced            = false
  daily_quota_gb                  = -1
  internet_ingestion_enabled      = true
  internet_query_enabled          = true
  local_authentication_disabled   = true
  retention_in_days               = 30
  sku                             = "PerGB2018"
  # reservation_capacity_in_gb_per_day = 100
}

resource "azurerm_log_analytics_solution" "log_analytics_solution" {
  for_each              = local.log_analytics_solutions
  workspace_name        = azurerm_log_analytics_workspace.log_analytics.name
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
  location              = var.location
  resource_group_name   = azurerm_resource_group.management_rg.name
  tags                  = var.tags

  solution_name = each.value.solution_name
  plan {
    publisher = each.value.plan.publisher
    product   = each.value.plan.product
  }
}

resource "azurerm_log_analytics_linked_storage_account" "log_analytics_linked_storage_account" {
  for_each              = toset(local.log_analytics_data_source_types)
  data_source_type      = each.key
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
  resource_group_name   = azurerm_resource_group.management_rg.name

  storage_account_ids = [
    azurerm_storage_account.storage.id
  ]
}
