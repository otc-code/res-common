output "tags" {
  value       = module.common_full.tags
  description = "A Map of tags based on the input variables which can be referred from hcl."
}

output "lc" {
  value       = module.common_full.lc
  description = "The Location Code based on the cloud region."
}

output "name_prefix" {
  value       = module.common_full.name_prefix
  description = "The name prefix."
}

output "dcl_class" {
  value = {
    dcl_class = module.common_full.dcl.class
    dcl_level = module.common_full.dcl.level
  }
  description = "The Data Classification class and the Level of the class."
}

output "locals" {
  value       = module.common_full.locals
  description = "The locals for usage in other modules."
}
