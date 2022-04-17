# Generating name for resource group
resource "random_pet" "rg-name" {
  prefix    = var.resource_group_name_prefix
}

# Generating name for resource group
resource "random_pet" "rg-name-two" {
  prefix    = var.resource_group_name_prefix
 }

# Creating resource group
resource "azurerm_resource_group" "rg" {
  name      = random_pet.rg-name.id
  location  = var.resource_group_location
  tags      = var.rg_tags
}

# Creating resource group
resource "azurerm_resource_group" "rg_two" {
  name      = random_pet.rg-name-two.id
  location  = var.resource_group_location
  tags      = var.rg_tags
}
