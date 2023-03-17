locals {
  mg_decommissioned_archetype_config_overrides = {
    archetype_id   = "custom_decommissioned"
    parameters     = {}
    access_control = {}
  }

  mg_decommissioned_subscription_id_overrides = var.mg_decommissioned_subscription_ids
}
