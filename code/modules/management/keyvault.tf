resource "azurerm_key_vault" "key_vault" {
  name                = "${local.root_id}-kv"
  location            = var.location
  resource_group_name = azurerm_resource_group.cmk_rg.name
  tags                = var.tags

  access_policy                   = []
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
  public_network_access_enabled = false
  purge_protection_enabled      = true
  sku_name                      = "standard"
  soft_delete_retention_days    = 7
  tenant_id                     = data.azurerm_client_config.current.tenant_id
}

# resource "azurerm_key_vault_key" "key_vault_key" {  # Requires access to dataplane
#   name         = "cmk"
#   key_vault_id = azurerm_key_vault.key_vault.id

#   key_type = "RSA"
#   key_size = 2048
#   key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

#   depends_on = [
#     azurerm_role_assignment.role_assignment_key_vault_current
#   ]
# }

resource "azapi_resource" "key_vault_key" {
  type      = "Microsoft.KeyVault/vaults/keys@2022-11-01"
  name      = "cmk"
  parent_id = azurerm_key_vault.key_vault.id

  body = jsonencode({
    properties = {
      attributes = {
        enabled    = true
        exp        = 1709484065
        exportable = false
      }
      curveName = "P-256"
      keyOps = [
        "decrypt",
        "encrypt",
        "sign",
        "unwrapKey",
        "verify",
        "wrapKey"
      ]
      keySize = 2048
      kty     = "RSA"
    }
  })

  response_export_values = ["properties.keyUriWithVersion"]
}
