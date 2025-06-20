
output "rg_name" {
  value = azurerm_resource_group.this.name
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "subnet_app_id" {
  value = azurerm_subnet.app.id
}

output "subnet_db_id" {
  value = azurerm_subnet.db.id
}

output "subnet_appgateway_id" {
  value = azurerm_subnet.appgateway.id
}

output "subnet_bastion_id" {
  value = azurerm_subnet.bastion.id
}

output "subnet_vm_id" {
  value = azurerm_subnet.vm.id
}
