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

output "random_string"{
   value     = random_string.password.result
}
#output "vm_two_pip" {
#   value     = azurerm_public_ip.vmtwopip.ip_address
#}

