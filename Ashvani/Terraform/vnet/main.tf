
resource "azurerm_virtual_network" "this" {
  for_each = var.vnet

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  # Either address_space or ip_address_pool (using address_space)
  address_space = lookup(each.value, "address_space", [])

  # Optional parameters (using lookup)
  dns_servers                   = lookup(each.value, "dns_servers", [])
  bgp_community                 = lookup(each.value, "bgp_community", null)
  edge_zone                     = lookup(each.value, "edge_zone", null)
  flow_timeout_in_minutes       = lookup(each.value, "flow_timeout_in_minutes", null)
  private_endpoint_vnet_policies = lookup(each.value, "private_endpoint_vnet_policies", "Disabled")

  # DDoS Protection (optional)
  dynamic "ddos_protection_plan" {
    for_each = lookup(each.value, "ddos_protection_plan", null) != null ? [each.value.ddos_protection_plan] : []
    content {
      id     = lookup(ddos_protection_plan.value, "id", null)
      enable = lookup(ddos_protection_plan.value, "enable", false)
    }
  }

  # Encryption (optional)
  dynamic "encryption" {
    for_each = lookup(each.value, "encryption", null) != null ? [each.value.encryption] : []
    content {
      enforcement = lookup(encryption.value, "enforcement", "AllowUnencrypted")
    }
  }

  # Subnets (inline + dynamic)
  dynamic "subnet" {
    for_each = lookup(each.value, "subnets", [])
    iterator = sn
    content {
      name         = sn.value.name
      address_prefixes = lookup(sn.value, "address_prefixes", [])
      security_group   = lookup(sn.value, "security_group", null)
      route_table_id   = lookup(sn.value, "route_table_id", null)

      service_endpoints = lookup(sn.value, "service_endpoints", [])
      private_endpoint_network_policies = lookup(sn.value, "private_endpoint_network_policies", null)
      private_link_service_network_policies_enabled = lookup(sn.value, "private_link_service_network_policies_enabled", true)
    }
  }

  tags = lookup(each.value, "tags", {})
}
