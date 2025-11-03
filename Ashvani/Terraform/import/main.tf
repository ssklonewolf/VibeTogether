terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "4.5"
    }
  }
}
provider "azurerm" {
  features {
    
  }
  subscription_id = "b3e9b690-1f69-4cae-899a-6a1c65b2db91"
}
import {
  to = azurerm_resource_group.rg
  id="/subscriptions/b3e9b690-1f69-4cae-899a-6a1c65b2db91/resourceGroups/rg_saurav"
}
resource "azurerm_resource_group" "rg" {
  name = "rg_saurav"
  location = "Southeast Asia"
}