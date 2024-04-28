variable "application" {
  type        = string
  description = "Application Name"
}

variable "environment" {
  type        = string
  description = "Environment Name"
}

variable "owner" {
  type        = string
  description = "Owner of the project"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "vnet_id" {
  type        = string
  description = "Virtual Network ID"
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources"
}
