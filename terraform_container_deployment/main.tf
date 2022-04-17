resource "random_pet" "rg-name" {
  prefix    = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "example" {
  name      = random_pet.rg-name.id
  location  = var.resource_group_location
  tags      = var.rg_tags
}

resource "azurerm_container_group" "example" {
  name      = "example-continst"
  resource_group_name = azurerm_resource_group.example.name
  location  = azurerm_resource_group.example.location
  ip_address_type = "public"
  dns_name_label  = "tf-containerinst-ra"
  os_type         = "Linux"


  container {
   name		= "testvwcontainer"
   image	= "vaultwarden/server:latest"
   cpu		= "0.5"
   memory 	= "1.5"

   ports {
    port 	= 80
    protocol	= "TCP"
   }
}
tags = var.rg_tags

}
