variable "resource_group_name_prefix" {
  default       = "rg"
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  default = "uksouth"
  description   = "Location of the resource group."
}

variable "rg_tags" {
  default = {Provisioner = "Terraform"}
  description = "Test adding tag via terraform"
}

variable "vm_name" {
  default = "tfDemo" 
  description = "Name of VM"

}

variable "my_home_pip" {
  default	= "88.109.203.209"
  description	= "Public IP address of my home network"
}
