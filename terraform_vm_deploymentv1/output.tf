output "resource_group_name" {
     value = azurerm_resource_group.rg.name
}

output "resource_group_tags" {
     value = azurerm_resource_group.rg.tags
}

output "vnet_name" {
    value  = azurerm_virtual_network.myterraformnetwork.name
}

output "vm_admin_user"{
    value = azurerm_windows_virtual_machine.vmOne.admin_username
}

output "random_password"{
   value     = random_password.password.result
   sensitive = true
}

#output "rg_name" {
#     value = random_pet.rg-name
#}


#output "resource_group_name_two" {
#    value = azurerm_resource_group.rg_two.name
#}
