variable "vnet" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    address_space        = list(string)
    dns_servers          = optional(list(string), [])
    tags                 = optional(map(string), {})
    subnets              = optional(list(object({
      name              = string
      address_prefix    = string
      service_endpoints = optional(list(string))
      private_endpoint_network_policies = optional(string)
      private_link_service_network_policies = optional(string)
    })), [])
    enable_ddos_protection = optional(bool, false)
    enable_vm_protection   = optional(bool, false)
    bastion_host           = optional(object({
      name       = string
      subnet_id  = string
    }))
    peerings = optional(list(object({
      name                      = string
      remote_virtual_network_id = string
      allow_forwarded_traffic   = optional(bool, false)
      allow_gateway_transit     = optional(bool, false)
      use_remote_gateways       = optional(bool, false)
    })), [])
  }))
}
