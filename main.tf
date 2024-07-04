locals {
  location_code = jsondecode(file("${path.module}/location_codes.json"))
  locals = jsondecode(templatefile("${path.module}/locals.json.tpl", {
    s             = "-"
    location_code = local.location_code[var.cloud_region].code
    custom_name   = var.custom_name
    prefix        = var.config.prefix
    environment   = var.config.environment
    application   = var.config.application
    productive    = var.config.productive
    customer      = var.config.customer
    businessunit  = var.config.businessunit
    project       = var.config.project
    costcenter    = var.config.costcenter
    owner         = var.config.owner
    dcl_class     = local.dcl_class[local.level]
  }))
  tags = merge(var.custom_tags, local.locals.global_tags, { "OPS:Source" : var.version_info })
}

