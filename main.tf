provider "azurerm" {
  features {}
subscription_id = "POC_SUBSCRIPTION_ID"
   
}
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "azure-test-keyvault" {
  name     = "keyvault-resources"
  location = "West US"
}

resource "azurerm_key_vault" "test" {
  name                        = "test-keyvault-testPoc"
  location                    = azurerm_resource_group.azure-test-keyvault.location
  resource_group_name         = azurerm_resource_group.azure-test-keyvault.name
  enabled_for_disk_encryption = true
  tenant_id       = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  tags = {
    environment = "PoC"
  }
}

resource "azurerm_key_vault_access_policy" "test_policy" {
  key_vault_id = azurerm_key_vault.test.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",       # Allow reading secrets
    "List",      # Allow listing secrets
    "Set",       # Allow setting (creating/updating) secrets
    "Delete",    # Allow deleting secrets
    
  ]
}
resource "azurerm_key_vault_secret" "mysecrets" {
  name         = "person1"
  value        = "passwordstrong"
  key_vault_id = azurerm_key_vault.test.id
}
