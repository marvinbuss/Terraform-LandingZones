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

variable "log_analytics_id" {
  description = "Specifies the resource ID of the Log Analytics Workspace"
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.log_analytics_id)) == 9
    error_message = "Please specify a valid resource ID."
  }
}
