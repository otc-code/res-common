# OpenTofu IaC Module for Global Tagging (otc-code/res-common)

The 'otc-code/res-common' module is designed to facilitate global tagging across various cloud environments using
Terraform. This module simplifies the process of applying consistent tags to resources, ensuring compliance with
organizational standards and reducing manual errors.

<!-- BEGIN_TOC -->

-   [OpenTofu IaC Module for Global Tagging (otc-code/res-common)](#opentofu-iac-module-for-global-tagging-otc-coderes-common)
-   [Overview](#overview)
    -   [Usage](#usage)
    -   [Created Resources](#created-resources)

<!-- END_TOC -->

# Overview

The common resource module provides Global Naming & Tags standards for all OTC tofu Modules. Naming will provide mainly
a "name_prefix" which you can use for resource naming.

The name prefix will be max. 48 characters long.

`prefix`-`location_code`-`environment`-`application`-`custom_name`-

```console
         1         2         3         4        5         6
12345678901234567890123456789012345678901234567801234567890
PPPPP-LLLL-EEE-AAAAAAAAAAAAAAAA-CCCCCCCCCCCCCCCC-
```

## Usage

The commons have defined map outputs which can be used within the modules to reference data from the commons module.

The minimum for invoking the module should be all mandatory variables:

| Variable            | Description                                                                             | Mandatory (purpose) | Constraints                                                 |
| ------------------- | --------------------------------------------------------------------------------------- | ------------------- | ----------------------------------------------------------- |
| cloud_region        | Which cloud region / location should be used                                            | ✔ (Name)            | For Azure -> location & for AWS, GCP -> region              |
| config.prefix       | Fixed customer prefix                                                                   | ✔ (Name)            | len 1-5, a-z, A-Z, 0-9 (First character has to be a letter) |
| config.environment  | Environment (dev/tst/int/uat/e2e/prd)                                                   | ✔ (Name&Tag)        | [dev, tst, int, uat, e2e, prd]                              |
| config.application  | Application name                                                                        | ✔ (Name&Tag)        | len 16, a-z, A-Z, - , 0-9                                   |
| config.customer     | Customer name                                                                           | ✗ (Tag)             | string                                                      |
| config.businessunit | Top-level division of your company that owns the workload that the resource belongs to. | ✗ (Tag)             | string                                                      |
| config.project      | Project Name                                                                            | ✗ (Tag)             | string                                                      |
| config.cost_center  | CostCenter                                                                              | ✗ (Tag)             | string                                                      |
| config.owner        | Owner                                                                                   | ✗ (Tag)             | string                                                      |
| custom_name         | Custom Name for the Resource deployment                                                 | ✗ (Name)            | len 16, a-z, A-Z, 0-9                                       |
| custom_tags         | Add custom tags from map to the tags                                                    | ✗ (Tag)             | Map of custom tags                                          |

To utilize this module effectively, follow these steps in your Terraform configuration files:

1.  **Module Source**: Ensure you specify the correct version of the module using a Git reference. Replace `<Version>`
    with the actual version tag or branch name from the repository.

    ```hcl
    module "res-common" {
      source = "git::https://github.com/otc-code/res-common.git?ref=<Version>"

      # Define your variables here as per the documentation below
      config = {
        prefix       = "your_prefix"
        environment  = "dev"
        application  = "exampleApp"
        productive   = false
        customer     = "customerName"
        businessunit = "businessUnit"
        project      = "projectCode"
        costcenter   = "costCenterNumber"
        owner        = "ownerEmail@domain.com"
      }

      custom_tags = {
        "customTagKey1" = "customTagValue1"
        "customTagKey2" = "customTagValue2"
      }

      cloud_region = "us-east-1"  # Example region, replace with your actual region
    }
    ```

2.  **Configuration Variables**: The module accepts a configuration object (`config`) which includes mandatory fields
    such as `prefix`, `environment`, and `application`. Optional parameters like `productive`, `customer`, etc., are also
    available for flexibility. Additionally, you can pass custom tags via the `custom_tags` variable to further customize
    resource tagging.

3.  **Outputs**: The module provides several outputs that can be used in downstream modules or for debugging purposes:
    -   `locals`: A map of useful local variables derived from input configurations.
    -   `tags`: Merged tags based on the input variables.
    -   `version_tag`: Semantic versioning tag for the module.
    -   `lc`: Location code specific to the provided cloud region.

By following this guide, you can easily integrate global tagging into your Terraform projects using the '
otc-code/res-common' module, ensuring consistency and compliance across all environments.

## Created Resources

This module creates:

-   **Tags**: Automatically applies predefined tags based on configuration parameters such as environment, application,
    and more.
-   **Name Prefix**: Compute a name prefix to simplify naming accross ressources & cloud providers.
-   **Location Code**: Based on the cloud region provided in the configuration file, it will return the appropriate
    location code for that cloud provider.

# Automated docs

<!-- BEGIN_TF_DOCS -->

## terraform-docs

### Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.6  |

### Providers

No providers.

### Modules

No modules.

### Resources

No resources.

### Inputs

| Name                                                                  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Type                                                                                                                                                                                                                                                                                                                                                                                  | Default                                                                                                       | Required |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_cloud_region"></a> [cloud_region](#input_cloud_region) | Define the cloud region to use (AWS Region / Azure Location / GCP region) which tf should use.                                                                                                                                                                                                                                                                                                                                                                                                                 | `string`                                                                                                                                                                                                                                                                                                                                                                              | n/a                                                                                                           |    yes   |
| <a name="input_config"></a> [config](#input_config)                   | Global config Object which contains the mandatory information's for deploying resources to ensure tagging.                                                                                                                                                                                                                                                                                                                                                                                                     | <pre>object({<br>    prefix       = string<br>    environment  = string<br>    application  = string<br>    productive   = optional(bool, false)<br>    customer     = optional(string, "")<br>    businessunit = optional(string, "")<br>    project      = optional(string, "")<br>    costcenter   = optional(string, "")<br>    owner        = optional(string, "")<br>  })</pre> | n/a                                                                                                           |    yes   |
| <a name="input_custom_name"></a> [custom_name](#input_custom_name)    | Set custom name for deployment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `string`                                                                                                                                                                                                                                                                                                                                                                              | `""`                                                                                                          |    no    |
| <a name="input_custom_tags"></a> [custom_tags](#input_custom_tags)    | A map of custom tags.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `map(string)`                                                                                                                                                                                                                                                                                                                                                                         | `null`                                                                                                        |    no    |
| <a name="input_dcl"></a> [dcl](#input_dcl)                            | Data classification to determine protection class (normal, high, very_high) based on:<br>- Integrity: The information is reliable and cannot be manipulated.<br>- Confidentiality: Only authorized persons have access to the information.<br>- Availability: Information is available at the times requested.<br><br>Base coverage is not complete, but is a first step. Only when you have reached the next level of standard protection are all topics for the category of normal protection needs covered. | <pre>object({<br>    integrity       = optional(string, "normal")<br>    confidentiality = optional(string, "normal")<br>    availability    = optional(string, "normal")<br>  })</pre>                                                                                                                                                                                               | <pre>{<br>  "availability": "normal",<br>  "confidentiality": "normal",<br>  "integrity": "normal"<br>}</pre> |    no    |
| <a name="input_version_info"></a> [version_info](#input_version_info) | Version information from the callling module, used for tagging.                                                                                                                                                                                                                                                                                                                                                                                                                                                | `string`                                                                                                                                                                                                                                                                                                                                                                              | `"n/a"`                                                                                                       |    no    |

### Outputs

| Name                                                                 | Description                                                                |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| <a name="output_dcl"></a> [dcl](#output_dcl)                         | The Data Classification class and the Level of the class.                  |
| <a name="output_lc"></a> [lc](#output_lc)                            | The Location Code based on the cloud region.                               |
| <a name="output_locals"></a> [locals](#output_locals)                | Usefull locals for usage in other modules.                                 |
| <a name="output_name_prefix"></a> [name_prefix](#output_name_prefix) | The name prefix.                                                           |
| <a name="output_tags"></a> [tags](#output_tags)                      | A Map of tags based on the input variables which can be referred from hcl. |

<!-- END_TF_DOCS -->

<!-- BEGIN_CHECKOV -->

## Checkov findings (none)

> 🎉 CONGRATS! No findings found in Code.

**Skipped checks**:

<!-- END_CHECKOV -->
