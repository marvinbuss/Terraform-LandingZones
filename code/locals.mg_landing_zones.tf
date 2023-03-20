locals {
  mg_landing_zones_archetype_config_overrides = {
    archetype_id = "custom_landing_zones"
    parameters = {
      Cmplnt-CognitiveServices = {
        cognitiveServicesNetworkAccess             = "Deny",
        cognitiveServicesPublicNetworkAccess       = "Deny",
        cognitiveServicesModifyPublicNetworkAccess = "Modify",
        cognitiveServicesModifyDisableLocalAuth    = "Modify",
        cognitiveServicesDisableLocalAuth          = "Deny",
        cognitiveServicesCustomerStorage           = "Deny",
        cognitiveServicesCmk                       = "Deny",
        cognitiveServicesManagedIdentity           = "Deny",
        cognitiveServicesNetworkAcls               = "Deny",
        cognitiveServicesOutboundNetworkAccess     = "Deny",
        cognitiveServicesDiagnostics               = "Disabled", # "DeployIfNotExists",
        cognitiveServicesLogAnalyticsWorkspaceId   = var.log_analytics_id
      }

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
        storageSftp                                     = "Deny",
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
        storageFileSyncDiagnostics               = "Disabled", # "DeployIfNotExists",
        storageFileSyncLogAnalyticsWorkspaceId   = var.log_analytics_id,
        storageTableDiagnostics                  = "Disabled", # "DeployIfNotExists",
        storageTableLogAnalyticsWorkspaceId      = var.log_analytics_id,
        storageAccountsDiagnostics               = "Disabled", # "DeployIfNotExists",
        storageAccountsLogAnalyticsWorkspaceId   = var.log_analytics_id,
        storageQueueDiagnostics                  = "Disabled", # "DeployIfNotExists",
        storageQueueLogAnalyticsWorkspaceId      = var.log_analytics_id,
        storageBlobDiagnostics                   = "Disabled", # "DeployIfNotExists",
        storageBlobLogAnalyticsWorkspaceId       = var.log_analytics_id,
        diagFileMetrics                          = false,
        diagBlobMetrics                          = false,
        diagQueueMetrics                         = false,
        diagTableMetrics                         = false
      }

      Cmplnt-KeyVault = {
        keyVaultPurgeProtection                      = "Deny",
        keyVaultHmsPurgeProtection                   = "Deny",
        keyVaultArmRbac                              = "Deny",
        keyVaultManagedHsmDisablePublicNetwork       = "Deny",
        keyVaultSoftDelete                           = "Deny",
        keyVaultDisablePublicNetwork                 = "Deny",
        keyVaultManagedHsmDisablePublicNetworkModify = "Modify",
        keyVaultDiagnostics                          = "Disabled", # "DeployIfNotExists",
        keyVaultLogAnalyticsWorkspaceId              = var.log_analytics_id,
        keyVaultCertificatesPeriod                   = "Disabled",
        keyVaultCertValidPeriod                      = 12,
        keyVaultKeysExpiration                       = "Deny",
        keyVaultHmsKeysExpiration                    = "Deny",
        keyVaultSecretExpiration                     = "Deny",
        keysValidPeriod                              = "Disabled",
        keysValidityInDays                           = 90,
        secretsValidPeriod                           = "Deny",
        secretsValidityInDays                        = 90,
        keyVaultFw                                   = "Deny",
        keyVaultCertKeyTypes                         = "Deny",
        keyVaultCertKeyTypesAllowed = [
          "RSA",
          "RSA-HSM"
        ],
        keyVaultEllipticCurve = "Deny",
        keyVaultEllipticCurveAllowed = [
          "P-256",
          "P-256K",
          "P-384",
          "P-521"
        ],
        keyVaultModifyFw          = "Modify",
        keyVaultCryptographicType = "Deny",
        keyVaultCryptographicTypeAllowed = [
          "RSA",
          "RSA-HSM",
          "EC",
          "EC-HSM"
        ],
        keysExpiration       = "Disabled",
        keysExpirationInDays = 30,
        keysActive           = "Disabled",
        keysActiveInDays     = 90,
        keysCurveNames       = "Deny",
        keysCurvesAllowed = [
          "P-256",
          "P-256K",
          "P-384",
          "P-521"
        ],
        secretsExpiration                     = "Disabled",
        secretsMoreInDays                     = 30,
        secretsActiveInDays                   = 90,
        secretsActive                         = "Disabled",
        hsmDiagnostics                        = "Disabled", # "DeployIfNotExists",
        hsmDiagnosticsCategories              = "allLogs",
        hsmDiagnosticsLocation                = ["*"],
        hsmDiagnosticsLogAnalyticsWorkspaceId = var.log_analytics_id,
      }
    }
    access_control = {}
  }

  mg_landing_zones_subscription_id_overrides = var.mg_landing_zones_subscription_ids
}
