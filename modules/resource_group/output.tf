output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
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

output "location_short" {
  value = var.location_short
}
