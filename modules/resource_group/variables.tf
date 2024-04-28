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
  default     = "swedencentral"
}

variable "location_short" {
  type        = string
  description = "Azure Region short name"
  default     = "sc"
}
