# ---------------------------------------------------------------------------------------------------------------------
# Global Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "cloud_region" {
  type        = string
  description = "Define the cloud region to use (AWS Region / Azure Location / GCP region) which tf should use."
  validation {
    condition = contains([
      "af-south-1", "ap-east-1", "ap-northeast-1",
      "ap-northeast-2", "ap-northeast-3", "ap-south-1",
      "ap-southeast-1", "ap-southeast-2", "australiaeast",
      "ca-central-1", "canadacentral", "centralindia",
      "centralus", "eastasia", "eastus", "eu-central-1",
      "eastus2", "eu-north-1", "eu-south-1",
      "eu-west-1", "eu-west-2", "eu-west-3",
      "francecentral", "germanywestcentral", "japaneast",
      "jioindiawest", "koreacentral", "me-south-1",
      "northcentralus", "northeurope", "norwayeast",
      "sa-east-1", "southafricanorth", "southcentralus",
      "southeastasia", "swedencentral", "switzerlandnorth",
      "uaenorth", "uksouth", "us-east-1",
      "us-east-2", "us-west-1", "us-west-2",
      "westeurope", "westus", "westus2",
      "westus3", "europe-west3"
    ], lower(var.cloud_region))
    error_message = "Valid values for cloud_region: af-south-1, ap-east-1, ap-northeast-1, ap-northeast-2, ap-northeast-3, ap-south-1, ap-southeast-1, ap-southeast-2, australiaeast, ca-central-1, canadacentral, centralindia, centralus, eastasia, eastus, eu-central-1, eastus2, eu-north-1, eu-south-1, eu-west-1, eu-west-2, eu-west-3, francecentral, germanywestcentral, japaneast, jioindiawest, koreacentral, me-south-1, northcentralus, northeurope, norwayeast, s-east-1, southafricanorth, southcentralus, southeastasia, swedencentral, switzerlandnorth, uaenorth, uksouth, us-east-1, us-east-2, us-west-1, us-west-2, westeurope, westus, westus2, westus3, europe-west3."
  }
}

variable "config" {
  type = object({
    prefix       = string
    environment  = string
    application  = string
    productive   = optional(bool, false)
    customer     = optional(string, "")
    businessunit = optional(string, "")
    project      = optional(string, "")
    costcenter   = optional(string, "")
    owner        = optional(string, "")
  })
  description = "Global config Object which contains the mandatory information's for deploying resources to ensure tagging."

  validation {
    condition     = length(var.config.environment) <= 3 && length(regexall("[^a-zA-Z0-9]", var.config.prefix)) == 0
    error_message = "Environment must be not longer than 3 characters containing only letters and numbers."
  }

  validation {
    condition     = var.config.prefix == "" || (length(var.config.prefix) <= 5 && length(regexall("[^a-zA-Z0-9]", var.config.prefix)) == 0)
    error_message = "The customer_prefix must be either empty and not longer than 5 characters containing only letters and numbers."
  }

  validation {
    condition     = length(var.config.application) <= 16 && length(regexall("[^a-zA-Z0-9-]", var.config.application)) == 0
    error_message = "The application must not be longer than 15 characters and only contain letters, '-' and numbers."
  }
}

variable "dcl" {
  type = object({
    integrity       = optional(string, "normal")
    confidentiality = optional(string, "normal")
    availability    = optional(string, "normal")
  })
  default = {
    integrity       = "normal"
    confidentiality = "normal"
    availability    = "normal"
  }
  validation {
    condition     = contains(["normal", "high", "very_high"], var.dcl.integrity)
    error_message = "Integrity must be one of the following: normal, high, very_high"
  }
  validation {
    condition     = contains(["normal", "high", "very_high"], var.dcl.confidentiality)
    error_message = "Confidentiality must be one of the following: normal, high, very_high"
  }
  validation {
    condition     = contains(["normal", "high", "very_high"], var.dcl.availability)
    error_message = "Availability must be one of the following: normal, high, very_high"
  }
  description = <<EOT
Data classification to determine protection class (normal, high, very_high) based on:
- Integrity: The information is reliable and cannot be manipulated.
- Confidentiality: Only authorized persons have access to the information.
- Availability: Information is available at the times requested.

Base coverage is not complete, but is a first step. Only when you have reached the next level of standard protection are all topics for the category of normal protection needs covered.
EOT
}

# ---------------------------------------------------------------------------------------------------------------------
# Custom Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "custom_tags" {
  type        = map(string)
  default     = null
  description = "A map of custom tags."
}

variable "custom_name" {
  type        = string
  default     = ""
  description = "Set custom name for deployment."
  validation {
    condition     = length(var.custom_name) <= 16 && length(regexall("[^a-zA-Z0-9-]", var.custom_name)) == 0
    error_message = "The custom name must not be longer than 16 characters and only contain letters, '-' and numbers."
  }
}

variable "version_info" {
  type        = string
  default     = "n/a"
  description = "Version information from the callling module, used for tagging."
}