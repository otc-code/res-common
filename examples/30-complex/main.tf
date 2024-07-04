module "common_full" {
  source       = "../.."
  cloud_region = "europe-west3"
  config = {
    prefix       = "12345"
    environment  = "tst"
    application  = "1234567890123456"
    customer     = "Sample GMBH"
    businessunit = "MyOrg"
    project      = "MyProject"
    costcenter   = "0815"
    owner        = "mm@example.com"
  }
  dcl = {
    integrity       = "high"
    confidentiality = "normal"
    availability    = "very_high"
  }
  custom_name = "1234567890123456"
  custom_tags = {
    test = "test"
  }
  version_info = "res-common:v0.0.1"
}

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
