module "management" {
  source = "./modules/management"
  providers = {
    azurerm = azurerm.management
   }

  location = local.management_location
  root_id  = local.root_id
  tags     = local.management_resources_tags
}
