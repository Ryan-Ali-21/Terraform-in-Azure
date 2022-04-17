output "resource_group_name" {
     value = azurerm_resource_group.example.name
}

output "resource_group_tags" {
     value = azurerm_resource_group.example.tags
}

output "dns_name_label" {
     value = azurerm_container_group.example.dns_name_label
}
