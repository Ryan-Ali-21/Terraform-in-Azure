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
