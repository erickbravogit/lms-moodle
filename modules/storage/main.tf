
resource "azurerm_storage_account" "this" {
  name                     = "st${replace(var.name_prefix, "-", "")}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Premium"
  account_replication_type = "LRS"
  account_kind             = "FileStorage"
}

resource "azurerm_storage_share" "moodledata" {
  name                 = "moodledata"
  storage_account_id   = azurerm_storage_account.this.id
  quota                = 100
}
