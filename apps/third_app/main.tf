module "app3_rg" {
  source = "../../modules/resource_group"

  application = var.application
  environment = var.environment
  owner       = var.owner

  location       = "swedencentral"
  location_short = "sc"
}

module "app3_networking" {
  source = "../../modules/networking"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix

  resource_group_name = module.app3_rg.resource_group_name
  location            = module.app3_rg.resource_group_location

  address_space = ["10.2.0.0/16"]

  subnets = {
    "default_subnet" = {
      name              = "default"
      address_prefix    = "10.2.0.0/24"
      service_endpoints = []
    }
  }

  is_nat_deployed = false

}

module "app3_nsg" {
  source = "../../modules/network_security"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix
  name        = "default"

  resource_group_name = module.app3_rg.resource_group_name
  location            = module.app3_rg.resource_group_location
  subnet_id           = module.app3_networking.subnets["default_subnet"].id

  nsg_rules = [
    {
      name                       = "Allow-SSH-From-VPN"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "34.77.75.213"
      destination_address_prefix = "*"
    }
  ]
}

module "app3_vm" {
  source = "../../modules/virtual_machine"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix

  resource_group_name = module.app3_rg.resource_group_name
  location            = module.app3_rg.resource_group_location
  subnet_id           = module.app3_networking.subnets["default_subnet"].id
  sg_id               = module.app3_nsg.network_security_group_id
  vm_size             = "Standard_B1s"

  create_public_ip = true
  instances        = 1
}
