resource "azurerm_storage_account" "storage" {
  name                = replace("${local.root_id}-stg", "-", "")
  location            = var.location
  resource_group_name = azurerm_resource_group.export_rg.name
  tags                = var.tags
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.user_assigned_identity_cmk.id
    ]
  }

  access_tier                     = "Hot"
  account_kind                    = "StorageV2"
  account_replication_type        = "RAGRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = true
  allowed_copy_scope              = "AAD"
  blob_properties {
    change_feed_enabled = false
    container_delete_retention_policy {
      days = 7
    }
    delete_retention_policy {
      days = 7
    }
    default_service_version  = "2020-06-12"
    last_access_time_enabled = false
    versioning_enabled       = false
  }
  customer_managed_key {
    user_assigned_identity_id = azurerm_user_assigned_identity.user_assigned_identity_cmk.id
    key_vault_key_id          = jsondecode(azapi_resource.key_vault_key.output).properties.keyUriWithVersion # data.azurerm_key_vault_key.key_vault_key.id
  }
  cross_tenant_replication_enabled = false
  default_to_oauth_authentication  = true
  enable_https_traffic_only        = true
  # immutability_policy {
  #   state                         = "Disabled"
  #   allow_protected_append_writes = true
  #   period_since_creation_in_days = 7
  # }
  infrastructure_encryption_enabled = true
  is_hns_enabled                    = false
  large_file_share_enabled          = false
  min_tls_version                   = "TLS1_2"
  network_rules {
    bypass                     = ["AzureServices"]
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
  nfsv3_enabled                 = false
  public_network_access_enabled = true
  queue_encryption_key_type     = "Account"
  table_encryption_key_type     = "Account"
  routing {
    choice                      = "MicrosoftRouting"
    publish_internet_endpoints  = false
    publish_microsoft_endpoints = false
  }
  sftp_enabled              = false
  shared_access_key_enabled = true
}

resource "azurerm_storage_management_policy" "storage_management_policy" {
  storage_account_id = azurerm_storage_account.storage.id

  rule {
    name    = "default"
    enabled = true
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than = 360
        # delete_after_days_since_modification_greater_than = 720
      }
      snapshot {
        change_tier_to_cool_after_days_since_creation = 180
        delete_after_days_since_creation_greater_than = 360
      }
      version {
        change_tier_to_cool_after_days_since_creation = 180
        delete_after_days_since_creation              = 360
      }
    }
    filters {
      blob_types   = ["blockBlob"]
      prefix_match = []
    }
  }
}

# resource "azurerm_storage_container" "storage_containers" {  # Requires access to dataplane
#   for_each             = toset(local.storage_container_names)
#   name                 = each.key
#   storage_account_name = azurerm_storage_account.storage.name

#   container_access_type = "private"
# }

resource "azapi_resource" "storage_containers" {
  for_each  = toset(local.storage_container_names)
  type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01"
  name      = each.key
  parent_id = "${azurerm_storage_account.storage.id}/blobServices/default"

  body = jsonencode({
    properties = {
      publicAccess = "None"
      metadata     = {}
    }
  })
}
