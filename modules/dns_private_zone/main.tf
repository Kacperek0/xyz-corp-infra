resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "${var.prefix}-${var.application}-${var.environment}.mysql.database.azure.com"
  resource_group_name = var.resource_group_name

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                = "${var.prefix}-${var.application}-${var.environment}-vnetlink.dns.azure.com"
  resource_group_name = var.resource_group_name

  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.vnet_id
}
