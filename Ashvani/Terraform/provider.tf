terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {

  }
  subscription_id = "b3e9b690-1f69-4cae-899a-6a1c65b2db91"
}