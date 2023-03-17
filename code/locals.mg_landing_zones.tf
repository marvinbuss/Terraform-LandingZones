locals {
  mg_landing_zones_archetype_config_overrides = {
    archetype_id = "custom_landing_zones"
    parameters = {
      Cmplnt-Storage = {
        storageKeysExpiration                           = "Deny",
        modifyStorageFileSyncPublicEndpoint             = "Modify",
        storageFileSyncPublicEndpoint                   = "Deny",
        storageFileSyncDiagnostics                      = "DeployIfNotExists",
        storageFileSyncLogAnalyticsWorkspaceId          = var.log_analytics_id,
        storageAccountNetworkRules                      = "Deny",
        storageTableDiagnostics                         = "DeployIfNotExists",
        storageTableLogAnalyticsWorkspaceId             = var.log_analytics_id,
        storageAccountRestrictNetworkRules              = "Deny",
        storageThreatProtection                         = "DeployIfNotExists",
        storageClassicToArm                             = "Deny",
        storageAccountSecureTransfer                    = "Deny",
        storageAccountsInfraEncryption                  = "Deny",
        storageAccountsPublicAccess                     = "Deny",
        storageAccountsDiagnostics                      = "DeployIfNotExists",
        storageAccountsLogAnalyticsWorkspaceId          = var.log_analytics_id,
        storageAccountsCmk                              = "Deny",
        storageQueueDiagnostics                         = "DeployIfNotExists",
        storageQueueLogAnalyticsWorkspaceId             = var.log_analytics_id,
        storageTableCmk                                 = "Deny",
        storageAccountSharedKey                         = "Deny",
        storageAccountsCrossTenant                      = "Deny",
        storageAccountsModifyDisablePublicNetworkAccess = "Modify",
        storageAccountsDisablePublicNetworkAccess       = "Deny",
        storageAccountsDoubleEncryption                 = "Deny",
        storageQueueCmk                                 = "Deny",
        storageAccountsTls                              = "Deny",
        storageAccountsEncryptionCmk                    = "Deny",
        storageAccountsCopyScope                        = "Deny",
        storageAccountsAllowedCopyScope                 = "AAD",
        storageServicesEncryption                       = "Deny",
        storageLocalUser                                = "Deny",
        storageNetworkAclsBypass                        = "Deny",
        storageAllowedNetworkAclsBypass = [
          "None"
        ],
        storageResourceAccessRulesTenantId       = "Deny",
        storageResourceAccessRulesResourceId     = "Deny",
        storageNetworkAclsVirtualNetworkRules    = "Deny",
        storageAllowBlobPublicAccess             = "Deny",
        storageContainerDeleteRetentionPolicy    = "Deny",
        storageMinContainerDeleteRetentionInDays = 7,
        storageCorsRules                         = "Deny",
        storageBlobDiagnostics                   = "DeployIfNotExists",
        storageBlobLogAnalyticsWorkspaceId       = var.log_analytics_id,
        storageBlobPrivateDnsZone                = "Disabled",
        storageBlobPrivateDnsZoneId              = "",
        storageSecondaryBlobPrivateDnsZone       = "Disabled",
        storageSecondaryBlobPrivateDnsZoneId     = "",
        storageDfsPrivateDnsZone                 = "Disabled",
        storageSecondaryDfsPrivateDnsZone        = "Disabled",
        storageSecondaryDfsPrivateDnsZoneId      = "",
        storageQueuePrivateDnsZone               = "Disabled",
        storageQueuePrivateDnsZoneId             = "",
        storageSecondaryQueuePrivateDnsZone      = "Disabled",
        storageSecondaryQueuePrivateDnsZoneId    = "",
        storageWebPrivateDnsZone                 = "Disabled",
        storageWebPrivateDnsZoneId               = "",
        storageSecondaryWebPrivateDnsZone        = "Disabled",
        storageSecondaryWebPrivateDnsZoneId      = "",
        modifyStorageAccountPublicEndpoint       = "Modify",
        diagFileMetrics                          = false,
        diagBlobMetrics                          = false,
        diagQueueMetrics                         = false,
        diagTableMetrics                         = false
      }
    }
    access_control = {}
  }
}