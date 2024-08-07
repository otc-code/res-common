# Load the commons module
module "common" {
  source       = "git::https://github.com/otc-code/res-common.git?ref=main"
  cloud_region = "eu-central-1"
  config = {
    prefix      = "otcrs"
    environment = "DEV"
    application = "common-40exdddds"
  }
  custom_name = "MyName"
}

locals {

  # Calculate the names from the names template file
  names = jsondecode(templatefile("${path.module}/names.tpl.json", { common = module.common }))
}
