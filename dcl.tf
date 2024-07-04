locals {
  integrity_level = {
    normal    = 1
    high      = 2
    very_high = 3
  }

  confidentiality_level = {
    normal    = 1
    high      = 2
    very_high = 3
  }
  availability_level = {
    normal    = 1
    high      = 2
    very_high = 3
  }
  # Data Classification Levels
  dcl_class = {
    1 = "basic"
    2 = "standard"
    3 = "highest"
  }
  level = max(local.integrity_level[var.dcl.integrity], local.confidentiality_level[var.dcl.confidentiality], local.availability_level[var.dcl.availability])
}
