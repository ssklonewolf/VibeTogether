
variable "vnet" {
  description = "Map of Virtual Networks configuration"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    # Either address_space or ip_address_pool (here using address_space)
    address_space = optional(list(string))

    # Optional parameters
    dns_servers                   = optional(list(string))
    bgp_community                 = optional(string)
    edge_zone                     = optional(string)
    flow_timeout_in_minutes       = optional(number)
    private_endpoint_vnet_policies = optional(string)

    # DDoS protection block
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))

    # Encryption block
    encryption = optional(object({
      enforcement = string
    }))

    # Subnets block
    subnets = optional(list(object({
      name                                      = string
      address_prefixes                          = list(string)
      security_group                            = optional(string)
      route_table_id                            = optional(string)
      service_endpoints                         = optional(list(string))
      private_endpoint_network_policies         = optional(string)
      private_link_service_network_policies_enabled = optional(bool)
    })))

    # Peering block
    peerings = optional(list(object({
      name                      = string
      remote_virtual_network_id = string
      allow_forwarded_traffic   = optional(bool)
      allow_gateway_transit     = optional(bool)
      use_remote_gateways       = optional(bool)
    })))

    # Tags
    tags = optional(map(string))
  }))
}
