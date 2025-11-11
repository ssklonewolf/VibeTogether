resource "azurerm_resource_group" "rg" {
  name = "rg_aks"
  location = "westus"
  tags = {
    owner="ashvani"
    environment="dev"
  }
  lifecycle {
    prevent_destroy = false
    create_before_destroy = false
    ignore_changes = [ tags ]
  }
}