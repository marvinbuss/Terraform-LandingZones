locals {
  mg_corp_archetype_config_overrides = {
    archetype_id   = "custom_corp"
    parameters     = {}
    access_control = {}
  }

  mg_corp_subscription_id_overrides = var.mg_corp_subscription_ids
}
