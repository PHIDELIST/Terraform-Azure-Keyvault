provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "azure-test-keyvault" {
  name     = "keyvault-resources"
  location = "West US"
}

resource "azurerm_key_vault" "test" {
  name                        = "test-keyvault"
  location                    = azurerm_resource_group.azure-test-keyvault.location
  resource_group_name         = azurerm_resource_group.azure-test-keyvault.name
  enabled_for_disk_encryption = true

  sku_name = "standard"

  tags = {
    environment = "PoC"
  }
}

resource "azurerm_key_vault_secret" "mysecrets" {
  name         = "person1"
  value        = "passwordstrong"
  key_vault_id = azurerm_key_vault.test.id
}
