# The following block of locals are used to avoid using
# empty object types in the code
locals {
  empty_list   = []
  empty_map    = tomap({})
  empty_string = ""
}

locals {
  root_id          = var.root_id
  root_name        = var.root_name
  default_location = var.default_location
  log_analytics_workspace_resource_id = var.log_analytics_workspace_resource_id
  
}