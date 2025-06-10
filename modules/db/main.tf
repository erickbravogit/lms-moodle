
resource "azurerm_mysql_flexible_server" "this" {
  name                   = "mysql-${var.name_prefix}"
  resource_group_name    = var.rg_name
  location               = var.location
  administrator_login    = "moodleadmin"
  administrator_password = var.admin_password
  sku_name               = "B_Standard_B1ms"
  version                = "8.0.21"
  zone                   = "1"
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = null

 # high_availability {
 #   mode = "SameZone"
 # }

  storage {
    size_gb = 50
  }

}
