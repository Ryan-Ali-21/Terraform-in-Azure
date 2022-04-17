output "resource_group_name" {
     value = azurerm_resource_group.rg.name
}

output "resource_group_tags" {
     value = azurerm_resource_group.rg.tags
}


output "resource_group_name_two" {
    value = azurerm_resource_group.rg_two.name
}
