data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "KVRG" {
  name     = var.KVRG
  location = var.KVLoc
}

resource "azurerm_key_vault" "KV_std" {
  name                        = var.KVname
  location                    = azurerm_resource_group.KVRG.location
  resource_group_name         = azurerm_resource_group.KVRG.name
  enabled_for_disk_encryption = var.KVEncy
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.KVRT
  purge_protection_enabled    = var.KVPPE
  sku_name = var.KVSKU
}
resource "azurerm_key_vault_access_policy" "KVACP" {
  key_vault_id = azurerm_key_vault.KV_std.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
      "Create",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Update",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ]

  secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "List",
      "Purge",
      "Recover"
    ]
}


resource "azurerm_key_vault_key" "KVKey" {
  name         = var.KVKname
  key_vault_id = azurerm_key_vault.KV_std.id
  key_type     = var.KVKty
  key_size     = var.KVKSZ

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "random_password" "RDMPas" {
  length = 20
  special = true
}

resource "azurerm_key_vault_secret" "vmpassword" {
  name         = var.KVSCrt
  value        = random_password.RDMPas.result
  key_vault_id = azurerm_key_vault.KV_std.id
  depends_on = [ azurerm_key_vault.KV_std ]

}