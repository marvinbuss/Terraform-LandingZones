module "archetypes" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "5.0.2"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  # Base module configuration settings.
  root_parent_id           = data.azurerm_client_config.current.tenant_id
  root_id                  = local.root_id
  root_name                = local.root_name
  default_location         = local.default_location
  default_tags             = local.default_tags
  disable_base_module_tags = false
  disable_telemetry        = true
  custom_policy_roles      = {}

  # Landing Zone configuration
  custom_landing_zones        = local.custom_landing_zones
  deploy_core_landing_zones   = true
  deploy_corp_landing_zones   = true
  deploy_diagnostics_for_mg   = false
  deploy_online_landing_zones = false
  deploy_sap_landing_zones    = false
  deploy_demo_landing_zones   = false

  # Connectivity configuration
  deploy_connectivity_resources    = false
  subscription_id_connectivity     = ""
  configure_connectivity_resources = {}

  # Identity configuration
  deploy_identity_resources    = false
  subscription_id_identity     = ""
  configure_identity_resources = {}

  # Management configuration
  deploy_management_resources    = false
  subscription_id_management     = local.management_subscription_id
  configure_management_resources = {}

  # Policy configuration
  policy_non_compliance_message_default                  = "This resource {enforcementMode} be compliant with the assigned policy."
  policy_non_compliance_message_default_enabled          = true
  policy_non_compliance_message_enabled                  = true
  policy_non_compliance_message_enforced_replacement     = "must"
  policy_non_compliance_message_enforcement_placeholder  = "{enforcementMode}"
  policy_non_compliance_message_not_enforced_replacement = "should"
  policy_non_compliance_message_not_supported_definitions = [
    "/providers/Microsoft.Authorization/policyDefinitions/1c6e92c9-99f0-4e55-9cf2-0c234dc48f99",
    "/providers/Microsoft.Authorization/policyDefinitions/1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d",
    "/providers/Microsoft.Authorization/policyDefinitions/95edb821-ddaf-4404-9732-666045e056b4"
  ]

  # Subscription configuration
  strict_subscription_association = true

  # Specify delay configuration
  create_duration_delay = {
    "azurerm_management_group" : "30s",
    "azurerm_policy_assignment" : "30s",
    "azurerm_policy_definition" : "30s",
    "azurerm_policy_set_definition" : "30s",
    "azurerm_role_assignment" : "0s",
    "azurerm_role_definition" : "60s"
  }
  destroy_duration_delay = {
    "azurerm_management_group" : "0s",
    "azurerm_policy_assignment" : "0s",
    "azurerm_policy_definition" : "0s",
    "azurerm_policy_set_definition" : "0s",
    "azurerm_role_assignment" : "0s",
    "azurerm_role_definition" : "0s"
  }

  # Specify library path for archetypes
  library_path = "${path.root}/lib"

  # Custom archetype overwrites
  archetype_config_overrides = {
    root           = local.mg_root_archetype_config_overrides
    decommissioned = local.mg_decommissioned_archetype_config_overrides
    sandboxes      = local.mg_sandboxes_archetype_config_overrides
    landing-zones  = local.mg_landing_zones_archetype_config_overrides
    platform       = local.mg_platform_archetype_config_overrides
    connectivity   = local.mg_connectivity_archetype_config_overrides
    management     = local.mg_management_archetype_config_overrides
    identity       = local.mg_identity_archetype_config_overrides
    corp           = local.mg_corp_archetype_config_overrides
    # online         = {}
    # sap            = {}
  }
  subscription_id_overrides = {
    root           = local.mg_root_subscription_id_overrides
    decommissioned = local.mg_decommissioned_subscription_id_overrides
    sandboxes      = local.mg_sandboxes_subscription_id_overrides
    landing-zones  = local.mg_landing_zones_subscription_id_overrides
    platform       = local.mg_platform_subscription_id_overrides
    connectivity   = local.mg_connectivity_subscription_id_overrides
    management     = local.mg_management_subscription_id_overrides
    identity       = local.mg_identity_subscription_id_overrides
    corp           = local.mg_connectivity_subscription_id_overrides
  }

  # Specify custom archetype template variables
  template_file_variables = {
    user_assigned_identity_id = module.management.user_assigned_identity_id_policy
  }
}
