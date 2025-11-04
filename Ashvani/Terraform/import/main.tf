terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "4.5"
    }
    
  }
  backend "azurerm" {
    resource_group_name = "rg-1"
    storage_account_name = "sauravstorageacct1"
    container_name = "container"
    key                  = "prod.terraform.tfstate"
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