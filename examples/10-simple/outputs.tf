output "tags" {
  value       = module.common_simple.tags
  description = "A Map of tags based on the input variables which can be referred from hcl."
}

output "lc" {
  value       = module.common_simple.lc
  description = "The Location Code based on the cloud region."
}

output "name_prefix" {
  value       = module.common_simple.name_prefix
  description = "The name prefix."
}

output "dcl_class" {
  value = {
    dcl_class = module.common_simple.dcl.class
    dcl_level = module.common_simple.dcl.level
  }
  description = "The Data Classification class and the Level of the class."
}
