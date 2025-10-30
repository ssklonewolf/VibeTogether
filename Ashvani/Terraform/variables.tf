variable "rg" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string, null)
    tags       = optional(map(string), {})
  }))
}
variable "storage" {
  type = map(object({
    name                              = string
    location                          = string
    resource_group_name               = string
    replication_type                  = string
    account_tier                      = string
    account_kind                      = optional(string)
    access_tier                       = optional(string)
    provisioned_billing_model_version = optional(string)
    cross_tenant_replication_enabled  = optional(bool)
    edge_zone                         = optional(string)
    https_traffic_only_enabled        = optional(bool)
    # min_tls_version = optional(string,"TLS1_2") At this time min_tls_version is only supported in the Public Cloud, China Cloud, and US Government Cloud.
    allow_nested_items_to_be_public = optional(bool)
    shared_access_key_enabled       = optional(bool)
    public_network_access_enabled   = optional(bool)
    default_to_oauth_authentication = optional(bool)
    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))
    customer_managed_key = optional(object({
      key_vault_id = string
      key_name     = string
      key_version  = optional(string)
    }))
    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(list(string))
      ip_rules                   = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
    }))
    tags = optional(map(string))
  }))
}

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