locals {
  mg_sandboxes_archetype_config_overrides = {
    archetype_id   = "custom_sandboxes"
    parameters     = {}
    access_control = {}
  }

  mg_sandboxes_subscription_id_overrides = var.mg_sandboxes_subscription_ids
}
