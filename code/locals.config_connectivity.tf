# Configure the connectivity resources settings.
locals {
  connectivity_subscription_id = var.connectivity_subscription_id
  connectivity_location        = local.default_location
  connectivity_resources_tags  = var.connectivity_resources_tags
}
