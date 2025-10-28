resource "azurerm_resource_group" "rg" {
  for_each = var.rg
  name = each.value.name
  location = each.value.location
  managed_by = each.value.managed_by
  tags = each.value.tags
  lifecycle {
    prevent_destroy = false
    ignore_changes = [ tags ]
    create_before_destroy = false
  }
}