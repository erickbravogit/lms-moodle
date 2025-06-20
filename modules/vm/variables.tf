variable "name_prefix" {
  description = "Prefix to name all resources"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}


variable "subnet_id" {
  description = "ID of the subnet where the VM will be deployed"
  type        = string
}

variable "vm_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "vm_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}
