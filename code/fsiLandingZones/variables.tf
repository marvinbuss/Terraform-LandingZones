variable "organization_name" {
  description = "Specifies the name of the organization."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.organization_name) >= 2
    error_message = "Please specify an orgaization name with more than two characters."
  }
}

variable "location" {
  description = "Specifies the location for all Azure resources."
  type        = string
  sensitive   = false
}

variable "environment" {
  description = "Specifies the environment of the deployment."
  type        = string
  sensitive   = false
  default     = "dev"
  validation {
    condition     = contains(["dev", "tst", "qa", "prd"], var.environment)
    error_message = "Please use an allowed value: \"dev\", \"tst\", \"qa\" or \"prd\"."
  }
}

variable "prefix" {
  description = "Specifies the prefix for all resources created in this deployment."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.prefix) >= 2 && length(var.prefix) <= 10
    error_message = "Please specify a prefix with more than two and less than 10 characters."
  }
}

variable "tags" {
  description = "Specifies the tags that you want to apply to all resources."
  type        = map(string)
  sensitive   = false
  default     = {}
}

variable "connectivity_subscription_id" {
  description = "Specifies the id of the Azure subscription used for network platform resources."
  type        = string
  sensitive   = false
  validation {
    condition     = var.connectivity_subscription_id == "" || length(regexall("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$", var.connectivity_subscription_id)) > 0
    error_message = "Please specify a valid subscription id."
  }
}

variable "management_subscription_id" {
  description = "Specifies the id of the Azure subscription used for network platform resources."
  type        = string
  sensitive   = false
  validation {
    condition     = var.management_subscription_id == "" || length(regexall("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$", var.management_subscription_id)) > 0
    error_message = "Please specify a valid subscription id."
  }
}

variable "identity_subscription_id" {
  description = "Specifies the id of the Azure subscription used for network platform resources."
  type        = string
  sensitive   = false
  validation {
    condition     = var.identity_subscription_id == "" || length(regexall("^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$", var.management_subscription_id)) > 0
    error_message = "Please specify a valid subscription id."
  }
}
