locals {
  root_id          = var.root_id
  root_name        = var.root_name
  default_location = var.default_location
  default_tags     = var.default_tags

  custom_landing_zones = {
    "${local.root_id}-cloud-native" = {
      display_name               = "Cloud Native"
      parent_management_group_id = "${local.root_id}-landing-zones"
      subscription_ids           = local.mg_cloud_native_subscription_id_overrides
      archetype_config           = local.mg_cloud_native_archetype_config_overrides
    }
  }
}
