resource "azurerm_policy_definition" "policy_definitions" {
  for_each = local.policy_definitions_map

  name                = each.key
  management_group_id = azurerm_management_group.management_group_root.id

  display_name = try(each.value.properties.displayName, "")
  description  = try(each.value.properties.description, "")
  policy_type  = try(each.value.properties.policyType, "")
  mode         = "Custom"
  metadata     = jsonencode(try(each.value.properties.metadata, {}))
  parameters   = replace(jsonencode(try(each.value.properties.parameters, {})), "[[", "[")
  policy_rule  = replace(jsonencode(try(each.value.properties.policyRule, {})), "[[", "[")
}

resource "azurerm_policy_set_definition" "policy_set_definitions" {
  for_each = local.policy_set_definitions_map

  name                = each.key
  management_group_id = azurerm_management_group.management_group_root.id

  display_name = try(each.value.properties.displayName, "")
  description  = try(each.value.properties.description, "")
  policy_type  = "Custom"
  metadata     = jsonencode(try(each.value.properties.metadata, ""))
  parameters   = replace(jsonencode(try(each.value.properties.parameters, "")), "[[", "[")
  dynamic "policy_definition_group" {
    for_each = try(each.value.properties.policyDefinitionGroups, [])
    content {
      name         = policy_definition_group.value.name
      category     = policy_definition_group.value.category
      display_name = policy_definition_group.value.displayName
      description  = policy_definition_group.value.description
    }
  }
  dynamic "policy_definition_reference" {
    for_each = try(each.value.properties.policyDefinitions, [])
    content {
      policy_definition_id = policy_definition_reference.value.policyDefinitionId // TODO
      parameter_values     = replace(jsonencode(policy_definition_reference.value.parameters), "[[", "[")
      policy_group_names   = policy_definition_reference.value.groupNames
    }
  }

  depends_on = [
    azurerm_policy_definition.policy_definitions
  ]
}
