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

variable "location_short" {
  type        = string
  description = "Azure Region short name"
  default     = "ne"
}

variable "prefix" {
  type        = string
  description = "Prefix for the resources"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "sg_id" {
  type        = string
  description = "Network Security Group ID"
}

variable "create_public_ip" {
  type        = bool
  description = "Create Public IP"
  default     = false
}

variable "instances" {
  type        = number
  description = "Number of instances"
  default     = 1
}

variable "vm_size" {
  type        = string
  description = "Size of the VM"
  default     = "Standard_B1s"
}
