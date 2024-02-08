
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "azure-keyvault" {
  name     = "keyvault-resources"
  location = "West US"
}
