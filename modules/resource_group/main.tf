resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.application}-${var.environment}-${var.location_short}"
  location = var.location

  tags = {
    Application = var.application
    Environment = var.environment
    Owner       = var.owner
  }
}
