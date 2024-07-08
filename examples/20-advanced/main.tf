module "common_full" {
  source       = "../.."
  cloud_region = "westeurope"
  config = {
    prefix       = "otcrs"
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
    availability    = "normal"
  }
  custom_name = "1234567890123456"
  custom_tags = {
    test = "test"
  }
  version_info = "res-common:v0.0.1"
}
