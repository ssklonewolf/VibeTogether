terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {

  }
  subscription_id = "b3e9b690-1f69-4cae-899a-6a1c65b2db91"
}
data "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  resource_group_name  = "rg_tst"
  virtual_network_name = "vnet1"
}
resource "azurerm_network_interface" "main" {

  for_each            = var.vm
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configuration
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.subnet.id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
    }
  }
}

resource "azurerm_virtual_machine" "main" {
  for_each              = var.vm
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.main[each.key].id]
  vm_size               = each.value.vm_size
  name                  = each.value.name
  location              = each.value.location

  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
  storage_os_disk {
    name              = each.value.storage_os_disk_name
    caching           = each.value.caching
    create_option     = each.value.create_option
    managed_disk_type = each.value.managed_disk_type
  }
  os_profile {
    computer_name  = each.value.computer_name
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "dev"
  }
}
