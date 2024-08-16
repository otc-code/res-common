output "tags" {
  value       = local.tags
  description = "A Map of tags based on the input variables which can be referred from hcl."
}

output "lc" {
  value       = local.location_code[var.cloud_region].code
  description = "The Location Code based on the cloud region."
}

output "name_prefix" {
  value       = local.locals.name_prefix
  description = "The name prefix."
}

output "dcl" {
  value = {
    class = local.dcl_class[local.level]
    level = local.level
  }
  description = "The Data Classification class and the Level of the class."
}

output "locals" {
  value       = local.locals
  description = "Usefull locals for usage in other modules."
}