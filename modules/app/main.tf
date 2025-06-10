
resource "azurerm_service_plan" "this" {
  name                = "asp-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.rg_name
  os_type  = "Linux"
  sku_name = "S1"

}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id = azurerm_service_plan.this.id

  site_config {
    
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITES_PORT"                       = "80"
    "MARIADB_HOST"                        = var.mysql_fqdn
    "MARIADB_DATABASE"                    = "moodle"
    "MARIADB_USER"                        = "moodleadmin@${var.mysql_fqdn}"
    "MARIADB_PASSWORD"                    = var.database_password
    "DATABASE_HOST"                       = var.mysql_fqdn
    "DATABASE_HOST"     = var.mysql_fqdn
    "DATABASE_NAME"     = "moodle"
    "DATABASE_USER"     = "moodleadmin@${var.mysql_fqdn}"
    "DATABASE_PASSWORD" = var.database_password
  }
}
