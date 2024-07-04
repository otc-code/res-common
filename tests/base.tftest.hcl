run "full_variables" {
  variables {
    cloud_region = "europe-west3"
    config = {
      prefix       = "12345"
      environment  = "tst"
      application  = "1234567890123456"
      customer     = "Sample GMBH"
      businessunit = "MyOrg"
      project      = "MyProject"
      costcenter   = "0815"
      owner        = "Me"
    }
    dcl = {
      integrity       = "high"
      confidentiality = "normal"
      availability    = "normal"
    }
    custom_name = "1234567890123456"
    separator   = "_"
    custom_tags = {
      test = "test"
    }
    otc_ressource = "res-common:v0.0.1"
  }

  # locals
  assert {
    condition     = output.locals.environment == "tst"
    error_message = "Incorrect locals 'environment': ${output.locals.environment}"
  }

  assert {
    condition     = output.locals.prefix == "12345"
    error_message = "Incorrect locals 'prefix': ${output.locals.prefix}"
  }

  assert {
    condition     = output.locals.application == "1234567890123456"
    error_message = "Incorrect locals 'application': ${output.locals.application}"
  }
  assert {
    condition     = output.locals.custom_name == "1234567890123456"
    error_message = "Incorrect locals 'custom_name': ${output.locals.custom_name}"
  }
  assert {
    condition     = output.lc == "euw3"
    error_message = "Incorrect lc: ${output.lc}"
  }

  assert {
    condition     = output.separator == "_"
    error_message = "Incorrect separator: ${output.separator}"
  }

  assert {
    condition     = output.name_prefix == "12345_euw3_tst_1234567890123456_1234567890123456"
    error_message = "Incorrect name_prefix: ${output.name_prefix}"
  }
  assert {
    condition     = length(output.name_prefix) <= 48
    error_message = "Incorrect length of name_prefix: ${length(output.name_prefix)}"
  }
  assert {
    condition     = jsonencode(output.dcl_class) == "{\"dcl_class\":\"standard\",\"dcl_num\":2}"
    error_message = "Incorrect dcl_class: ${jsonencode(output.dcl_class)}"
  }
}
