module "archetypes" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "3.3.0"

  # Base module configuration settings.
  root_parent_id           = data.azurerm_client_config.current.tenant_id
  root_id                  = local.root_id
  root_name                = local.root_name
  default_location         = local.default_location
  default_tags             = local.default_tags

  # Policy configuration
  custom_policy_roles      = {}
  policy_non_compliance_message_default                  = "This resource {enforcementMode} be compliant with the assigned policy."
  policy_non_compliance_message_default_enabled          = true
  policy_non_compliance_message_enabled                  = true
  policy_non_compliance_message_enforcement_placeholder  = "{enforcementMode}"
  policy_non_compliance_message_enforced_replacement     = "must"
  policy_non_compliance_message_not_enforced_replacement = "should"
  policy_non_compliance_message_not_supported_definitions = [
    "/providers/Microsoft.Authorization/policyDefinitions/1c6e92c9-99f0-4e55-9cf2-0c234dc48f99",
    "/providers/Microsoft.Authorization/policyDefinitions/1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d",
    "/providers/Microsoft.Authorization/policyDefinitions/95edb821-ddaf-4404-9732-666045e056b4"
  ]

  # Subscription configuration
  strict_subscription_association = true

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
    cloud-native = local.mg_cloud_native_archetype_config_overrides
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
    cloud-native = local.mg_cloud_native_subscription_id_overrides
  }

  # Specify custom archetype template variables
  template_file_variables = {
    user_assigned_identity_id = module.management.user_assigned_identity_id_policy
  }
}
