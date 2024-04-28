module "app2_rg" {
  source = "../../modules/resource_group"

  application = var.application
  environment = var.environment
  owner       = var.owner

  location       = "swedencentral"
  location_short = "sc"
}

module "app2_networking" {
  source = "../../modules/networking"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix

  resource_group_name = module.app2_rg.resource_group_name
  location            = module.app2_rg.resource_group_location

  address_space = ["10.1.0.0/16"]

  subnets = {
    "default_subnet" = {
      name              = "default"
      address_prefix    = "10.1.0.0/24"
      service_endpoints = []
    }
  }

  is_nat_deployed = false

}

module "app2_nsg" {
  source = "../../modules/network_security"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix
  name        = "default"

  resource_group_name = module.app2_rg.resource_group_name
  location            = module.app2_rg.resource_group_location
  subnet_id           = module.app2_networking.subnets["default_subnet"].id

  nsg_rules = [
    {
      name                       = "Allow-SSH-From-App3"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow-HTTP-from-App1"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "10.0.0.0/24"
      destination_address_prefix = "*"
    }
  ]
}

module "app2_vm" {
  source = "../../modules/virtual_machine"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix

  resource_group_name = module.app2_rg.resource_group_name
  location            = module.app2_rg.resource_group_location
  subnet_id           = module.app2_networking.subnets["default_subnet"].id
  sg_id               = module.app2_nsg.network_security_group_id
  vm_size             = "Standard_B1s"

  create_public_ip = false
  instances        = 1
}

module "app2_dnszone" {
  source = "../../modules/dns_private_zone"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix

  resource_group_name = module.app2_rg.resource_group_name
  vnet_id             = module.app2_networking.vnet_id
}

module "app2_db" {
  source = "../../modules/sql"

  application = var.application
  environment = var.environment
  owner       = var.owner
  prefix      = var.prefix

  resource_group_name = module.app2_rg.resource_group_name
  location            = module.app2_rg.resource_group_location

  vnet_name                  = module.app2_networking.vnet_name
  db_subnet_address_prefixes = ["10.1.1.0/24"]
  private_dns_zone_id        = module.app2_dnszone.dns_private_zone_id

  name                = "app2db"
  administrator_login = "sqladmin"
}
