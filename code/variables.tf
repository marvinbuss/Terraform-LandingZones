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

variable "subscription_id_management" {
  type        = string
  description = "If specified, identifies the Platform subscription for \"Management\" for resource deployment and correct placement in the Management Group hierarchy."
  default     = ""

  validation {
    condition     = can(regex("^[a-z0-9-]{36}$", var.subscription_id_management)) || var.subscription_id_management == ""
    error_message = "Value must be a valid Subscription ID (GUID)."
  }
}