variable "root_id" {
  description = "Specifies the id of the root."
  type        = string
  sensitive   = false
}

variable "root_name" {
  description = "Specifies the name of the root."
  type        = string
  sensitive   = false
}

variable "default_location" {
  type        = string
  default     = "eastus"
  description = "Specifies the default location for resources, including references to location within Policy templates."
}

variable "default_tags" {
  type        = map(string)
  default     = {}
  description = "Specifies the default tags for resources."
}

variable "management_resources_tags" {
  type        = map(string)
  default     = {}
  description = "Specifies the tags for management resources."
}

variable "management_subscription_id" {
  type        = string
  description = "Specifies the subscription ID for management resources."
}

variable "identity_resources_tags" {
  type        = map(string)
  default     = {}
  description = "Specifies the tags for identity resources."
}

variable "identity_subscription_id" {
  type        = string
  description = "Specifies the subscription ID for identity resources."
}

variable "connectivity_resources_tags" {
  type        = map(string)
  default     = {}
  description = "Specifies the tags for connectivity resources."
}

variable "connectivity_subscription_id" {
  type        = string
  description = "Specifies the subscription ID for connectivity resources."
}

variable "mg_decommissioned_subscription_ids" {
  type        = list(string)
  default     = []
  description = "Specifies the subscription IDs to associate with decomissioned managemend group."
}

variable "mg_landing_zones_subscription_ids" {
  type        = list(string)
  default     = []
  description = "Specifies the subscription IDs to associate with landing zone managemend group."
}

variable "mg_sandboxes_subscription_ids" {
  type        = list(string)
  default     = []
  description = "Specifies the subscription IDs to associate with sandbox managemend group."
}

variable "mg_corp_subscription_ids" {
  type        = list(string)
  default     = []
  description = "Specifies the subscription IDs to associate with corp managemend group."
}

variable "mg_cloud_native_subscription_ids" {
  type        = list(string)
  default     = []
  description = "Specifies the subscription IDs to associate with the cloud-native managemend group."
}

variable "log_analytics_id" {
  description = "Specifies the resource ID of the Log Analytics Workspace"
  type        = string
  sensitive   = false
  validation {
    condition     = var.log_analytics_id == "" || length(split("/", var.log_analytics_id)) == 9
    error_message = "Please specify a valid resource ID."
  }
}
