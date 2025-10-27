#creating a resource group with terraform resource block wiht only required arguments
resource "azurerm_resource_group" "resource_group" {
    name     = "dev-ssk-rg-001"
    location = "centralindia"
}