output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnets" {
  value       = azurerm_subnet.subnet
  description = "The subnet resources"
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.nat[*].id
}
