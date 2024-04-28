module "app1_rg" {
  source = "../../modules/resource_group"

  application = var.application
  environment = var.environment
  owner       = var.owner

  location       = "swedencentral"
  location_short = "sc"
}

module "app1_networking" {
  source = "../../modules/networking"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix

  resource_group_name = module.app1_rg.resource_group_name
  location            = module.app1_rg.resource_group_location

  address_space = ["10.0.0.0/16"]

  subnets = {
    "default_subnet" = {
      name              = "default"
      address_prefix    = "10.0.0.0/24"
      service_endpoints = []
    },
    "gateway_subnet" = {
      name              = "GatewaySubnet"
      address_prefix    = "10.0.1.0/24"
      service_endpoints = []
    }
  }

  is_nat_deployed = false

}

module "app1_nsg" {
  source = "../../modules/network_security"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix
  name        = "default"

  resource_group_name = module.app1_rg.resource_group_name
  location            = module.app1_rg.resource_group_location
  subnet_id           = module.app1_networking.subnets["default_subnet"].id

  nsg_rules = [
    {
      name                       = "Allow-SSH-From-App3"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.2.0.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-HTTP-from-App2"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "10.1.0.0/24"
      destination_address_prefix = "*"
    }
  ]
}

module "app1_vnet_gw" {
  source = "../../modules/vnet_gateway"

  application = var.application
  environment = var.environment
  owner       = var.owner

  resource_group_name = module.app1_rg.resource_group_name
  location            = module.app1_rg.resource_group_location

  subnet_id = module.app1_networking.subnets["gateway_subnet"].id

  create_onprem_lgw      = true
  onprem_gateway_address = "34.77.75.213"
  onprem_address_space   = ["192.168.0.0/16"]

  create_onprem_connection = false
  shared_key               = "AzureA1b2C3"
}

module "app1_vm" {
  source = "../../modules/virtual_machine"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix

  resource_group_name = module.app1_rg.resource_group_name
  location            = module.app1_rg.resource_group_location
  subnet_id           = module.app1_networking.subnets["default_subnet"].id
  sg_id               = module.app1_nsg.network_security_group_id
  vm_size             = "Standard_B1s"

  create_public_ip = false
  instances        = 1
}
