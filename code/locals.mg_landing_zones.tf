locals {
  mg_landing_zones_archetype_config_overrides = {
    archetype_id = "custom_landing_zones"
    parameters = {
      Cmplnt-Storage = {
        storageKeysExpiration                           = "Deny",
        modifyStorageFileSyncPublicEndpoint             = "Modify",
        storageFileSyncPublicEndpoint                   = "Deny",
        storageAccountNetworkRules                      = "Deny",
        storageAccountRestrictNetworkRules              = "Deny",
        storageThreatProtection                         = "DeployIfNotExists",
        storageClassicToArm                             = "Deny",
        storageAccountSecureTransfer                    = "Deny",
        storageAccountsInfraEncryption                  = "Deny",
        storageAccountsPublicAccess                     = "Deny",
        storageAccountsCmk                              = "Deny",
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
        modifyStorageAccountPublicEndpoint       = "Modify"
      }
      # Cmplnt-PrivateDns = {
      #   storageBlobPrivateDnsZone                = "Disabled",
      #   storageBlobPrivateDnsZoneId              = "",
      #   storageSecondaryBlobPrivateDnsZone       = "Disabled",
      #   storageSecondaryBlobPrivateDnsZoneId     = "",
      #   storageDfsPrivateDnsZone                 = "Disabled",
      #   storageSecondaryDfsPrivateDnsZone        = "Disabled",
      #   storageSecondaryDfsPrivateDnsZoneId      = "",
      #   storageQueuePrivateDnsZone               = "Disabled",
      #   storageQueuePrivateDnsZoneId             = "",
      #   storageSecondaryQueuePrivateDnsZone      = "Disabled",
      #   storageSecondaryQueuePrivateDnsZoneId    = "",
      #   storageWebPrivateDnsZone                 = "Disabled",
      #   storageWebPrivateDnsZoneId               = "",
      #   storageSecondaryWebPrivateDnsZone        = "Disabled",
      #   storageSecondaryWebPrivateDnsZoneId      = "",
      # }
    }
    access_control = {}
  }
}
