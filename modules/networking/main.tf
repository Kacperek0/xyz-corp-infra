resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-${var.application}-${var.environment}-vnet"
  location            = var.location
  address_space       = var.address_space
  resource_group_name = var.resource_group_name

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.value["name"] == "GatewaySubnet" ? "GatewaySubnet" : "${var.prefix}-${var.application}-${var.environment}-subnet-${each.value["name"]}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value["address_prefix"]]
  service_endpoints    = each.value["service_endpoints"] != null ? each.value["service_endpoints"] : []
}

resource "azurerm_nat_gateway" "nat" {
  count               = var.is_nat_deployed ? 1 : 0
  name                = "${var.application}-${var.environment}-nat"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "azurerm_public_ip" "pip" {
  count               = var.is_nat_deployed ? 1 : 0
  name                = "${var.application}-${var.environment}-nat-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip" {
  count                = var.is_nat_deployed ? 1 : 0
  nat_gateway_id       = azurerm_nat_gateway.nat[count.index].id
  public_ip_address_id = azurerm_public_ip.pip[count.index].id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat" {
  count          = var.is_nat_deployed ? length(azurerm_subnet.subnet) : 0
  subnet_id      = azurerm_subnet.subnet[count.index].id
  nat_gateway_id = azurerm_nat_gateway.nat[0].id
}
