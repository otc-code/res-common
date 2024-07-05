module "common_simple" {
  source       = "../.."
  cloud_region = "eu-central-1"
  config = {
    prefix      = "otcrs"
    environment = "DEV"
    application = "10-simple"
  }
}
