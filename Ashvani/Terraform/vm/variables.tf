variable "vm" {
  type = map(object({
    name                = string
    resource_group_name = string
    nic_name            = string
    location            = string
    ip_configuration = list(object({
      name                          = string
      private_ip_address_allocation = string
    }))
    vm_size              = string
    publisher            = string
    offer                = string
    sku                  = string
    version              = string
    storage_os_disk_name = string
    caching              = string
    create_option        = string
    managed_disk_type    = string
    computer_name        = string
    admin_username       = string
    admin_password       = string

  }))
}
