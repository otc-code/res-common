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

    custom_tags = {
      test = "test"
    }
    version_info = "res-common:v0.0.1"
  }

  assert {
    condition     = output.lc == "euw3"
    error_message = "Incorrect lc: ${output.lc}"
  }

  assert {
    condition     = output.name_prefix == "12345-euw3-tst-1234567890123456-1234567890123456"
    error_message = "Incorrect name_prefix: ${output.name_prefix}"
  }
  assert {
    condition     = length(output.name_prefix) <= 48
    error_message = "Incorrect length of name_prefix: ${length(output.name_prefix)}"
  }
  assert {
    condition     = output.dcl.class == "standard"
    error_message = "Incorrect dcl_class: ${output.dcl.class}"
  }
}
