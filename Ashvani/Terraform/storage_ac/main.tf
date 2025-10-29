resource "azurerm_storage_account" "storage" {
  for_each = var.storage
  name                     = each.value.name
  location                 = each.value.location
  resource_group_name      = each.value.resource_group_name
  account_tier             = each.value.account_tier
  account_replication_type = each.value.replication_type
  account_kind             = each.value.account_kind
  access_tier              = each.value.access_tier

  # Optional properties — Terraform 1.3+ handles missing/null automatically
  provisioned_billing_model_version   = each.value.provisioned_billing_model_version
  cross_tenant_replication_enabled    = each.value.cross_tenant_replication_enabled
  edge_zone                           = each.value.edge_zone
  https_traffic_only_enabled          = each.value.https_traffic_only_enabled
  allow_nested_items_to_be_public     = each.value.allow_nested_items_to_be_public
  shared_access_key_enabled           = each.value.shared_access_key_enabled
  public_network_access_enabled       = each.value.public_network_access_enabled
  default_to_oauth_authentication     = each.value.default_to_oauth_authentication

  # Updated nested objects
  dynamic "custom_domain" {
    for_each = each.value.custom_domain == null ? [] : [each.value.custom_domain]
    content {
      name          = custom_domain.value.name
      use_subdomain = custom_domain.value.use_subdomain
    }
  }

#   dynamic "customer_managed_key" {
#     for_each = each.value.customer_managed_key == null ? [] : [each.value.customer_managed_key]
#     content {
#       key_vault_id = customer_managed_key.value.key_vault_id
#       key_name     = customer_managed_key.value.key_name
#       key_version  = customer_managed_key.value.key_version
#     }
#   }

  dynamic "network_rules" {
    for_each = each.value.network_rules == null ? [] : [each.value.network_rules]
    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }

  # Optional tags
  tags = each.value.tags

  # Prevent accidental deletion (optional safety)
  lifecycle {
    prevent_destroy = false
    create_before_destroy = false
    ignore_changes = [ tags ]
  }
}
