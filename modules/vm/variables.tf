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

variable "peer_vnet_name" {
  description = "Name of the VNet to peer with"
  type        = string
}

variable "peer_rg_name" {
  description = "Resource group name of the peer VNet"
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
