resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-${var.application}-${var.environment}-nic${var.instances}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "external"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.pip[0].id : null
  }

  tags = {
    application = var.application
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_public_ip" "pip" {
  count               = var.create_public_ip ? 1 : 0
  name                = "${var.prefix}-${var.application}-${var.environment}-pip${var.instances}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    application = var.application
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.sg_id
}

resource "azurerm_linux_virtual_machine" "linux_machine" {
  name                = "${var.prefix}-${var.application}-${var.environment}-vm${var.instances}"
  resource_group_name = azurerm_network_interface.nic.resource_group_name
  location            = azurerm_network_interface.nic.location
  size                = var.vm_size
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  disable_password_authentication = true
  patch_assessment_mode           = "AutomaticByPlatform"
  provision_vm_agent              = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    application = var.application
    environment = var.environment
    owner       = var.owner
  }
}
