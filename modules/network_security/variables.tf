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

variable "name" {
  type        = string
  description = "Name of the NSG"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "westeurope"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "nsg_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "Values for each NSG rule"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources"
}
