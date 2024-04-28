resource "random_string" "random" {
  length  = 6
  special = false
}

resource "azurerm_virtual_network_peering" "one-to-two" {
  name                      = "${var.first_prefix}-${var.first_application}-${var.first_environment}-peering-1-to-2-${random_string.random.result}"
  resource_group_name       = var.first_resource_group_name
  virtual_network_name      = var.first_vnet_name
  remote_virtual_network_id = var.second_vnet_id
}

resource "azurerm_virtual_network_peering" "two-to-one" {
  count                     = var.is_bidirectional ? 1 : 0
  name                      = "${var.second_prefix}-${var.second_application}-${var.second_environment}-vnet-peering-2-to-1-${random_string.random.result}"
  resource_group_name       = var.second_resource_group_name
  virtual_network_name      = var.second_vnet_name
  remote_virtual_network_id = var.first_vnet_id
}
