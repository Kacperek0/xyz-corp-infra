output "vnet_name" {
  value = module.app1_networking.vnet_name
}

output "vnet_id" {
  value = module.app1_networking.vnet_id
}

output "resource_group_name" {
  value = module.app1_rg.resource_group_name
}

output "application" {
  value = var.application
}

output "environment" {
  value = var.environment
}

output "owner" {
  value = var.owner
}

output "prefix" {
  value = var.prefix
}
