module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "3.3.0"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  # Base module configuration settings.
  root_parent_id   = data.azurerm_client_config.current.tenant_id
  root_id          = local.root_id
  root_name        = local.root_name
  default_location = local.default_location

  # Specify library path for 
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
    # corp           = {}
    # online         = {}
    # sap            = {}
  }

  # Specify custom template variables
  template_file_variables = {
    user_assigned_identity_id = ""
  }
}
