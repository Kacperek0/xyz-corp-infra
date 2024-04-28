data "azurerm_client_config" "current" {}

resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.prefix}-${var.application}-${var.environment}-${var.name}-db-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.db_subnet_address_prefixes

  service_endpoints = ["Microsoft.Storage"]

  delegation {
    name = "db-subnet-delegation"
    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_mysql_flexible_server" "sqldb" {
  name                = "${var.prefix}-${var.application}-${var.environment}-${var.name}-sql-db"
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "8.0.21"
  delegated_subnet_id = azurerm_subnet.db_subnet.id
  private_dns_zone_id = var.private_dns_zone_id
  zone                = "1"

  sku_name = "B_Standard_B1ms"

  administrator_login    = var.administrator_login
  administrator_password = data.azurerm_key_vault_secret.db_password.value

  backup_retention_days = 7

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  lower   = true
  numeric = true
}

resource "azurerm_key_vault" "kv" {
  name                       = "${var.application}${var.environment}-sql-${random_string.suffix.result}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  sku_name = "standard"

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "random_password" "password" {
  length           = 48
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "${var.prefix}-${var.application}-${var.environment}-${var.name}-db-password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.kv_ap]

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "azurerm_key_vault_access_policy" "kv_ap" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  certificate_permissions = []
  key_permissions         = []
  secret_permissions      = ["Get", "List", "Set"]
  storage_permissions     = []

  depends_on = [azurerm_key_vault.kv]

}

data "azurerm_key_vault_secret" "db_password" {
  name         = azurerm_key_vault_secret.db_password.name
  key_vault_id = azurerm_key_vault.kv.id
}
