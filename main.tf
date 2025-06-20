# Terraform main.tf (modular version) for Moodle LMS in Azure

provider "azurerm" {
    subscription_id = "61051401-08b4-4820-8044-8e8eb80d6786"
  features {}
}

variable "name_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "moodle-minsait"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US"
}

variable "admin_password" {
  description = "Admin password for MySQL"
  type        = string
  sensitive   = true
  default     = "P@ssword1234!"
}

variable "vm_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "vm_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
  default     = "ChangeMeP@ssword1!"
}

module "network" {
  source      = "./modules/network"
  name_prefix = var.name_prefix
  location    = var.location
}

module "db" {
  source         = "./modules/db"
  name_prefix    = var.name_prefix
  location       = var.location
  rg_name        = module.network.rg_name
  subnet_id      = module.network.subnet_db_id
  admin_password = var.admin_password
}

module "app" {
  source            = "./modules/app"
  name_prefix       = var.name_prefix
  location          = var.location
  rg_name           = module.network.rg_name
  mysql_fqdn        = module.db.mysql_fqdn
  database_password = var.admin_password
}

module "storage" {
  source      = "./modules/storage"
  name_prefix = var.name_prefix
  location    = var.location
  rg_name     = module.network.rg_name
}

module "vm" {
  source        = "./modules/vm"
  name_prefix   = var.name_prefix
  location      = var.location
  rg_name       = module.network.rg_name
  subnet_id     = module.network.subnet_vm_id
  vm_username   = var.vm_username
  vm_password   = var.vm_password
}

output "resource_group_name" {
  value = module.network.rg_name
}

output "app_service_url" {
  value = module.app.app_service_url
}

output "mysql_fqdn" {
  value = module.db.mysql_fqdn
}

output "vm_public_ip" {
  value = module.vm.public_ip
}
