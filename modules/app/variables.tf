
variable "name_prefix" {
  description = "Prefix to name all resources"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "mysql_fqdn" {
  description = "FQDN of the MySQL server"
  type        = string
}

variable "database_password" {
  description = "Password for connecting to the database"
  type        = string
  sensitive   = true
}
