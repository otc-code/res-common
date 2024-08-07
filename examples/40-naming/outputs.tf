output "rg_name" {
  value = local.names["azurerm_resource_group.this.name"]
}

output "azr_storage_name" {
  value = local.names["azurerm_storage_account.this.name"]
}

output "azr_storage_tag_name" {
  value = local.names["azurerm_storage_account.this.tag.name"]
}
