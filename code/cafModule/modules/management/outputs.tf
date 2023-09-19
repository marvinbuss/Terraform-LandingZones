output "user_assigned_identity_id_policy" {
  value       = azurerm_user_assigned_identity.user_assigned_identity_policy.id
  description = "Specifies the resource ID of the User Assigned Identity used for Azure Policy."
  sensitive   = false
}

output "log_analytics_workspace_id" {
  value       = azurerm_log_analytics_workspace.log_analytics.id
  description = "Specifies the resource ID of the Log Analytics workspace."
  sensitive   = false
}
