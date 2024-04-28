variable "application" {
  type        = string
  description = "Application/Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "owner" {
  type        = string
  description = "Owner of the project"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "create_onprem_lgw" {
  type        = bool
  description = "Create OnPrem Local Gateway"
  default     = false
}

variable "onprem_gateway_address" {
  type        = string
  description = "OnPrem Gateway Address"
}

variable "onprem_address_space" {
  type        = list(string)
  description = "OnPrem Address Space"
}

variable "create_onprem_connection" {
  type        = bool
  description = "Create OnPrem Connection"
  default     = false
}

variable "shared_key" {
  type        = string
  description = "Shared Key"
}

