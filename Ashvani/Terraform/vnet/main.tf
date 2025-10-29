resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space

  dns_servers         = lookup(each.value, "dns_servers", null)
  tags                = lookup(each.value, "tags", null)

  enable_ddos_protection = lookup(each.value, "enable_ddos_protection", false)
  enable_vm_protection   = lookup(each.value, "enable_vm_protection", false)
}

resource "azurerm_subnet" "subnet" {
  for_each = { for vnet_key, vnet_value in var.vnet : vnet_key => vnet_value.subnets if length(vnet_value.subnets) > 0 }

  dynamic "subnet" {
    for_each = each.value
    content {
      name                 = subnet.value.name
      resource_group_name  = azurerm_virtual_network.vnet[each.key].resource_group_name
      virtual_network_name = azurerm_virtual_network.vnet[each.key].name
      address_prefix       = subnet.value.address_prefix

      service_endpoints = lookup(subnet.value, "service_endpoints", null)
      private_endpoint_network_policies = lookup(subnet.value, "private_endpoint_network_policies", null)
      private_link_service_network_policies = lookup(subnet.value, "private_link_service_network_policies", null)
    }
  }
}

resource "azurerm_virtual_network_peering" "peering" {
  for_each = { for vnet_key, vnet_value in var.vnet : vnet_key => vnet_value.peerings if length(vnet_value.peerings) > 0 }

  dynamic "peering" {
    for_each = each.value
    content {
      name                      = peering.value.name
      resource_group_name       = azurerm_virtual_network.vnet[each.key].resource_group_name
      virtual_network_name      = azurerm_virtual_network.vnet[each.key].name
      remote_virtual_network_id = peering.value.remote_virtual_network_id

      allow_forwarded_traffic = lookup(peering.value, "allow_forwarded_traffic", false)
