resource "azurerm_role_definition" "role_definition_landing_zone_subscription_owner" {
  name  = "Landing Zone Subscription Owner"
  scope = azurerm_management_group.management_group_root.id

  assignable_scopes = [
    azurerm_management_group.management_group_root.id
  ]
  description = "Landing Zone Subscription Owner."
  permissions {
    actions = [
      "*"
    ]
    not_actions = [
      "Microsoft.Blueprint/blueprintAssignments/write",
      "Microsoft.Blueprint/blueprintAssignments/delete",
      "Microsoft.Network/vpnGateways/*",
      "Microsoft.Network/expressRouteCircuits/*",
      "Microsoft.Network/routeTables/write",
      "Microsoft.Network/routeTables/delete",
      "Microsoft.Network/routeTables/routes/write",
      "Microsoft.Network/azurefirewalls/write",
      "Microsoft.Network/azurefirewalls/delete",
      "Microsoft.Network/firewallPolicies/write",
      "Microsoft.Network/firewallPolicies/join/action",
      "Microsoft.Network/firewallPolicies/delete",
      "Microsoft.Network/firewallPolicies/ruleGroups/write",
      "Microsoft.Network/firewallPolicies/ruleGroups/delete",
      "Microsoft.Network/vpnSites/*",
      "Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies/*",
      "Microsoft.Network/networkSecurityGroups/securityRules/delete",
      "Microsoft.Network/networkSecurityGroups/delete",
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.Network/virtualNetworks/delete"
    ]
    data_actions     = []
    not_data_actions = []
  }
}

resource "azurerm_role_definition" "role_definition_platform_contributor" {
  name  = "Platform Contributor"
  scope = azurerm_management_group.management_group_root.id

  assignable_scopes = [
    azurerm_management_group.management_group_root.id
  ]
  description = "Custom Role that grants full access to manage all Platform resources, but does not allow you to assign roles in Azure RBAC, manage assignments in Azure Blueprints, or share image galleries."
  permissions {
    actions = [
      "*"
    ]
    not_actions = [
      "Microsoft.Authorization/*/Delete",
      "Microsoft.Authorization/*/Write",
      "Microsoft.Authorization/elevateAccess/Action",
      "Microsoft.Blueprint/blueprintAssignments/write",
      "Microsoft.Blueprint/blueprintAssignments/delete",
      "Microsoft.Compute/galleries/share/action"
    ]
    data_actions     = []
    not_data_actions = []
  }
}
