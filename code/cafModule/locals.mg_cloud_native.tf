locals {
  mg_cloud_native_archetype_config_overrides = {
    archetype_id   = "custom_cloud_native"
    parameters     = {}
    access_control = {}
  }

  mg_cloud_native_subscription_id_overrides = var.mg_cloud_native_subscription_ids
}
