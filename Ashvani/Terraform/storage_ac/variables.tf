variable "storage" {
  type = map(object({
    name = string
    location = string
    resource_group_name = string
    replication_type = string
    account_tier = string
    account_kind= optional(string )
    access_tier = optional(string )
    provisioned_billing_model_version =optional(string)
    cross_tenant_replication_enabled = optional(bool)
    edge_zone = optional(string)
    https_traffic_only_enabled = optional(bool)
    # min_tls_version = optional(string,"TLS1_2") At this time min_tls_version is only supported in the Public Cloud, China Cloud, and US Government Cloud.
    allow_nested_items_to_be_public = optional(bool)
    shared_access_key_enabled = optional(bool)
    public_network_access_enabled = optional(bool)
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