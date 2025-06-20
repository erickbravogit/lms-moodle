# Virtual network for VM
resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.name_prefix}-vm"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "vm" {
  name                 = "snet-vm"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_network_security_group" "vm" {
  name                = "nsg-${var.name_prefix}-vm"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "vm" {
  name                = "pip-${var.name_prefix}-vm"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "vm" {
  name                = "nic-${var.name_prefix}-vm"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}

resource "azurerm_network_interface_security_group_association" "vm" {
  network_interface_id      = azurerm_network_interface.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-app-${var.name_prefix}"
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_DS2_v3"
  admin_username      = var.vm_username
  admin_password      = var.vm_password
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.vm.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

# Peering with existing DB VNet

data "azurerm_virtual_network" "peer" {
  name                = var.peer_vnet_name
  resource_group_name = var.peer_rg_name
}

resource "azurerm_virtual_network_peering" "vm_to_db" {
  name                      = "${azurerm_virtual_network.this.name}-to-${data.azurerm_virtual_network.peer.name}"
  resource_group_name       = var.rg_name
  virtual_network_name      = azurerm_virtual_network.this.name
  remote_virtual_network_id = data.azurerm_virtual_network.peer.id
  allow_forwarded_traffic   = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "db_to_vm" {
  name                      = "${data.azurerm_virtual_network.peer.name}-to-${azurerm_virtual_network.this.name}"
  resource_group_name       = var.peer_rg_name
  virtual_network_name      = data.azurerm_virtual_network.peer.name
  remote_virtual_network_id = azurerm_virtual_network.this.id
  allow_forwarded_traffic   = true
  allow_virtual_network_access = true
}
