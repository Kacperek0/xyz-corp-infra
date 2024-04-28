variable "first_prefix" {
  type        = string
  description = "Prefix for the first VNET"
}

variable "second_prefix" {
  type        = string
  description = "Prefix for the second VNET"
}

variable "first_resource_group_name" {
  type        = string
  description = "Name of the first resource group"
}

variable "second_resource_group_name" {
  type        = string
  description = "Name of the second resource group"
}

variable "first_vnet_name" {
  type        = string
  description = "Name of the first VNET"
}

variable "second_vnet_name" {
  type        = string
  description = "Name of the second VNET"
}

variable "first_vnet_id" {
  type        = string
  description = "ID of the first VNET"
}

variable "second_vnet_id" {
  type        = string
  description = "ID of the second VNET"
}

variable "first_application" {
  type        = string
  description = "Application name"
}

variable "second_application" {
  type        = string
  description = "Application name"
}

variable "first_environment" {
  type        = string
  description = "Environment name"
}

variable "second_environment" {
  type        = string
  description = "Environment name"
}

variable "is_bidirectional" {
  type        = bool
  description = "Is the peering bidirectional"
  default     = true
}
