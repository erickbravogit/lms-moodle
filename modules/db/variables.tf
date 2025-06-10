
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

variable "subnet_id" {
  description = "ID of the subnet to delegate the database"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the MySQL server"
  type        = string
  sensitive   = true
}
