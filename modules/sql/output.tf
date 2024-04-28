variable "application" {
  type        = string
  description = "Application name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name" {
  type        = string
  description = "Name of the database"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}

variable "private_dns_zone_id" {
  type        = string
  description = "Private DNS Zone ID"
}

variable "administrator_login" {
  type        = string
  description = "Administrator login"
}

variable "owner" {
  type        = string
  description = "Owner of the database"
}

variable "vnet_name" {
  type        = string
  description = "Name of the VNET"
}

variable "db_subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the DB subnet"
}

variable "location_short" {
  type        = string
  description = "Azure Region short name"
  default     = "ne"
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources"
}
