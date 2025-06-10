
output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "file_share_name" {
  value = azurerm_storage_share.moodledata.name
}
