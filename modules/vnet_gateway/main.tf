resource "azurerm_public_ip" "vnet_gw_ip" {
  name                = "${var.application}-${var.environment}-vnet-gw-ip"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = "Standard"

  allocation_method = "Static"
}

resource "azurerm_virtual_network_gateway" "vent_gw" {
  name                = "${var.application}-${var.environment}-vnet-gw"
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vnet_gw_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }

  depends_on = [
    azurerm_public_ip.vnet_gw_ip
  ]
}

resource "azurerm_local_network_gateway" "onprem_lgw" {
  count               = var.create_onprem_lgw ? 1 : 0
  name                = "${var.application}-${var.environment}-onprem-lgw"
  location            = var.location
  resource_group_name = var.resource_group_name

  gateway_address = var.onprem_gateway_address
  address_space   = var.onprem_address_space
}

resource "azurerm_virtual_network_gateway_connection" "vnet_to_onprem" {
  count               = var.create_onprem_connection ? 1 : 0
  name                = "VNet-to-OnPrem"
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vent_gw.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem_lgw[*].id

  shared_key = var.shared_key
}
