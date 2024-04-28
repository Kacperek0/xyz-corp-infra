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

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "swedencentral"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
  default     = ["10.0.0.0/8"]
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "subnets" {
  type = map(object({
    name              = string
    address_prefix    = string
    service_endpoints = list(string)
  }))
  default = {
    "default_subnet" = {
      name              = "default"
      address_prefix    = "10.1.0.0/16"
      service_endpoints = []
    }
  }
  description = "Subnets for the virtual network"
}

variable "is_nat_deployed" {
  type        = bool
  description = "Flag to deploy NAT Gateway"
  default     = false
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources"
}
