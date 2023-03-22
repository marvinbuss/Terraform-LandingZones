# The following variables are used to configure the default
# Enterprise-scale Management Groups.
#
# Further information provided within the description block
# for each variable

variable "root_parent_id" {
  type        = string
  description = "The root_parent_id is used to specify where to set the root for all Landing Zone deployments. Usually the Tenant ID when deploying the core Enterprise-scale Landing Zones."

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_\\(\\)\\.]{1,36}$", var.root_parent_id))
    error_message = "Value must be a valid Management Group ID, consisting of alphanumeric characters, hyphens, underscores, periods and parentheses."
  }
}

variable "root_id" {
  type        = string
  description = "If specified, will set a custom Name (ID) value for the Enterprise-scale \"root\" Management Group, and append this to the ID for all core Enterprise-scale Management Groups."
  default     = "es"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{2,10}$", var.root_id))
    error_message = "Value must be between 2 to 10 characters long, consisting of alphanumeric characters and hyphens."
  }
}

variable "root_name" {
  type        = string
  description = "If specified, will set a custom Display Name value for the Enterprise-scale \"root\" Management Group."
  default     = "Enterprise-Scale"

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9- ._]{1,22}[A-Za-z0-9]?$", var.root_name))
    error_message = "Value must be between 2 to 24 characters long, start with a letter, end with a letter or number, and can only contain space, hyphen, underscore or period characters."
  }
}

variable "archetype_config_overrides" {
  type        = any
  description = "If specified, will set custom Archetype configurations for the core ALZ Management Groups. Does not work for management groups specified by the 'custom_landing_zones' input variable."
  default     = {}
}

variable "subscription_id_overrides" {
  type        = map(list(string))
  description = "If specified, will be used to assign subscription_ids to the default Enterprise-scale Management Groups."
  default     = {}
}

variable "library_path" {
  type        = string
  description = "If specified, sets the path to a custom library folder for archetype artefacts."
  default     = ""
}

variable "template_file_variables" {
  type        = any
  description = "If specified, provides the ability to define custom template variables used when reading in template files from the built-in and custom library_path."
  default     = {}
}

variable "default_location" {
  type        = string
  description = "If specified, will set the Azure region in which region bound resources will be deployed. Please see: https://azure.microsoft.com/en-gb/global-infrastructure/geographies/"
  default     = "eastus"
}

variable "default_tags" {
  type        = map(string)
  description = "If specified, will set the default tags for all resources deployed by this module where supported."
  default     = {}
}

variable "create_duration_delay" {
  type = object({
    azurerm_management_group      = optional(string, "30s")
    azurerm_policy_assignment     = optional(string, "30s")
    azurerm_policy_definition     = optional(string, "30s")
    azurerm_policy_set_definition = optional(string, "30s")
    azurerm_role_assignment       = optional(string, "0s")
    azurerm_role_definition       = optional(string, "60s")
  })
  description = "Used to tune terraform apply when faced with errors caused by API caching or eventual consistency. Sets a custom delay period after creation of the specified resource type."
  default = {
    azurerm_management_group      = "30s"
    azurerm_policy_assignment     = "30s"
    azurerm_policy_definition     = "30s"
    azurerm_policy_set_definition = "30s"
    azurerm_role_assignment       = "0s"
    azurerm_role_definition       = "60s"
  }

  validation {
    condition     = can([for v in values(var.create_duration_delay) : regex("^[0-9]{1,6}(s|m|h)$", v)])
    error_message = "The create_duration_delay values must be a string containing the duration in numbers (1-6 digits) followed by the measure of time represented by s (seconds), m (minutes), or h (hours)."
  }
}

variable "destroy_duration_delay" {
  type = object({
    azurerm_management_group      = optional(string, "0s")
    azurerm_policy_assignment     = optional(string, "0s")
    azurerm_policy_definition     = optional(string, "0s")
    azurerm_policy_set_definition = optional(string, "0s")
    azurerm_role_assignment       = optional(string, "0s")
    azurerm_role_definition       = optional(string, "0s")
  })
  description = "Used to tune terraform deploy when faced with errors caused by API caching or eventual consistency. Sets a custom delay period after destruction of the specified resource type."
  default = {
    azurerm_management_group      = "0s"
    azurerm_policy_assignment     = "0s"
    azurerm_policy_definition     = "0s"
    azurerm_policy_set_definition = "0s"
    azurerm_role_assignment       = "0s"
    azurerm_role_definition       = "0s"
  }

  validation {
    condition     = can([for v in values(var.destroy_duration_delay) : regex("^[0-9]{1,6}(s|m|h)$", v)])
    error_message = "The destroy_duration_delay values must be a string containing the duration in numbers (1-6 digits) followed by the measure of time represented by s (seconds), m (minutes), or h (hours)."
  }
}

variable "custom_policy_roles" {
  type        = map(list(string))
  description = "If specified, the custom_policy_roles variable overrides which Role Definition ID(s) (value) to assign for Policy Assignments with a Managed Identity, if the assigned \"policyDefinitionId\" (key) is included in this variable."
  default     = {}
}

variable "strict_subscription_association" {
  type        = bool
  description = "If set to true, subscriptions associated to management groups will be exclusively set by the module and any added by another process will be removed. If set to false, the module will will only enforce association of the specified subscriptions and those added to management groups by other processes will not be removed."
  default     = true
}

variable "policy_non_compliance_message_enabled" {
  type        = bool
  description = "If set to false, will disable non-compliance messages altogether."
  default     = true
}

variable "policy_non_compliance_message_not_supported_definitions" {
  type        = list(string)
  description = "If set, overrides the list of built-in policy definition that do not support non-compliance messages."
  default = [
    "/providers/Microsoft.Authorization/policyDefinitions/1c6e92c9-99f0-4e55-9cf2-0c234dc48f99",
    "/providers/Microsoft.Authorization/policyDefinitions/1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d",
    "/providers/Microsoft.Authorization/policyDefinitions/95edb821-ddaf-4404-9732-666045e056b4"
  ]
}

variable "policy_non_compliance_message_default_enabled" {
  type        = bool
  description = "If set to true, will enable the use of the default custom non-compliance messages for policy assignments if they are not provided."
  default     = true
}

variable "policy_non_compliance_message_default" {
  type        = string
  description = "If set overrides the default non-compliance message used for policy assignments."
  default     = "This resource {enforcementMode} be compliant with the assigned policy."
  validation {
    condition     = var.policy_non_compliance_message_default != null && length(var.policy_non_compliance_message_default) > 0
    error_message = "The policy_non_compliance_message_default value must not be null or empty."
  }
}

variable "policy_non_compliance_message_enforcement_placeholder" {
  type        = string
  description = "If set overrides the non-compliance message placeholder used in message templates."
  default     = "{enforcementMode}"
  validation {
    condition     = var.policy_non_compliance_message_enforcement_placeholder != null && length(var.policy_non_compliance_message_enforcement_placeholder) > 0
    error_message = "The policy_non_compliance_message_enforcement_placeholder value must not be null or empty."
  }
}

variable "policy_non_compliance_message_enforced_replacement" {
  type        = string
  description = "If set overrides the non-compliance replacement used for enforced policy assignments."
  default     = "must"
  validation {
    condition     = var.policy_non_compliance_message_enforced_replacement != null && length(var.policy_non_compliance_message_enforced_replacement) > 0
    error_message = "The policy_non_compliance_message_enforced_replacement value must not be null or empty."
  }
}

variable "policy_non_compliance_message_not_enforced_replacement" {
  type        = string
  description = "If set overrides the non-compliance replacement used for unenforced policy assignments."
  default     = "should"
  validation {
    condition     = var.policy_non_compliance_message_not_enforced_replacement != null && length(var.policy_non_compliance_message_not_enforced_replacement) > 0
    error_message = "The policy_non_compliance_message_not_enforced_replacement value must not be null or empty."
  }
}