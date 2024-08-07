# OpenTofu IaC Module for Global Tagging (otc-code/res-common)

[![LOGO](images/logo.png)](#)

[![OpenTofu Tests](https://github.com/otc-code/res-common/actions/workflows/test.yml/badge.svg)](https://github.com/otc-code/res-common/actions/workflows/test.yml)

<!-- BEGIN_TOC -->

## Table of Contents

-   [OpenTofu IaC Module for Global Tagging (otc-code/res-common)](#opentofu-iac-module-for-global-tagging-otc-coderes-common)
-   [Overview](#overview)
    -   [Usage](#usage)
-   [Details](#details)
    -   [Files](#files)
        -   [dcl.tf](#dcltf)
        -   [main.tf](#maintf)
        -   [outputs.tf](#outputstf)
        -   [versions.tf](#versionstf)
-   [Automated docs](#automated-docs)
    -   [terraform-docs](#terraform-docs)
        -   [Requirements](#requirements)
        -   [Providers](#providers)
        -   [Modules](#modules)
        -   [Resources](#resources)
        -   [Inputs](#inputs)
        -   [Outputs](#outputs)
    -   [Checkov findings (none)](#checkov-findings-none)
    -   [Permissions (Pike)](#permissions-pike)
        <!-- END_TOC -->

# Overview

The repository 'res-common' is an OpenTofu module designed for globally tagging and naming cloud resources. It ensures that all deployed resources are consistently tagged with mandatory information, such as environment, owner, and project details, which aids in resource management and compliance. This module is particularly useful in environments where consistent labeling across multiple projects or teams is crucial.

The name prefix will be max. 48 characters long.

`prefix`-`location_code`-`environment`-`application`-`custom_name`-

```console
         1         2         3         4        5         6
12345678901234567890123456789012345678901234567801234567890
PPPPP-LLLL-EEE-AAAAAAAAAAAAAAAA-CCCCCCCCCCCCCCCC-
```

## Usage

```hcl
module "res-common" {
  source = "git::https://github.com/otc-code/res-common.git?ref=<Version>"
  ...
}
```

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

# Details

The provided code  are related to defining tags for resources in an infrastructure as code (IaC) setup. Here's a concise overview of the key features from `res-common`:

1.  **Base Coverage**: Tags are defined with base coverage, which means they provide a basic level of protection but may not cover all aspects required for higher levels of standard protection.
2.  **Custom Tags**: Custom tags can be merged with global tags to ensure comprehensive labeling.
3.  **Version Information**: The version information is included as part of the source tag to track changes or versions of the infrastructure code.
4.  **Output**: The output provides a map of tags that can be referred to in HCL files for resource management and compliance.

**Key Features**:

-   **Tag Definitions**: Tags are defined based on data classification, determining protection class (normal, high, very_high).
-   **Error Handling**: An error message is provided if the availability level is not one of the specified options (`normal`, `high`, `very_high`).
-   **Description and Usage**: The tags are used to label resources in an IaC setup, ensuring compliance and management through standardized labels.

## Files

Structure:

```console
├── examples
│   ├── 10-simple
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── 20-advanced
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── README.md
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── 30-complex
│       ├── main.tf
│       ├── outputs.tf
│       ├── README.md
│       ├── variables.tf
│       └── versions.tf
├── images
│   └── logo.png
├── tests
│   ├── base.tftest.hcl
│   └── test.json
├── dcl.tf
├── LICENSE
├── locals.json.tpl
├── location_codes.json
├── main.tf
├── outputs.tf
├── README.md
├── variables.tf
└── versions.tf
```

### dcl.tf

The file `dcl.tf` is a Terraform configuration script that defines the data classification levels and their associated properties within an infrastructure-as-code (IaC) environment. This script uses local values to manage different aspects of data classification, such as integrity, confidentiality, and availability levels, which are crucial for ensuring compliance with organizational security policies and regulatory requirements.

Here's a breakdown of the key components in `dcl.tf`:

1.  **Integrity Levels**: Defines the numerical representation (1, 2, 3) for different integrity levels (`normal`, `high`, `very_high`). These levels are used to assess the trustworthiness and reliability of data.

2.  **Confidentiality Levels**: Similar to integrity, this section defines the confidentiality levels (`normal`, `high`, `very_high`) with their corresponding numerical values. Confidentiality ensures that sensitive information is protected from unauthorized access.

3.  **Availability Levels**: Defines how available data should be based on predefined levels (`normal`, `high`, `very_high`). High availability means ensuring that the system remains operational even in the face of failures or disruptions.

4.  **Data Classification Classes**: Maps numerical values to descriptive class names for easy understanding and reference. For example, a level 1 might correspond to "basic," level 2 to "standard," and level 3 to "highest."

5.  **Level Calculation**: Determines the overall classification level by taking the maximum value among integrity, confidentiality, and availability levels specified in variables (`var.dcl.integrity`, `var.dcl.confidentiality`, `var.dcl.availability`). This ensures that the most restrictive classification is used to govern access controls and data handling practices.

The script uses these definitions to provide a structured way of managing and enforcing security policies across various components of the infrastructure, making it easier to apply consistent security measures regardless of changes or additions to the system architecture.

### main.tf

The file `main.tf` is a Terraform configuration script that defines the infrastructure and settings for a deployment. It uses various Terraform features such as locals, variables, and outputs to manage resources efficiently. Here's a breakdown of its purpose:

1.  **Local Variables**:

    -   `location_code`: Decodes the content of `location_codes.json` into a map for easy access.
    -   `locals`: Uses a template file (`locals.json.tpl`) to dynamically generate local variables based on other variables and predefined values. This includes:
        -   `s`: A separator string.
        -   `location_code`: The code corresponding to the cloud region specified by `var.cloud_region`.
        -   `custom_name`, `prefix`, `environment`, `application`, `productive`, `customer`, `businessunit`, `project`, `costcenter`, `owner`: Variables that can be set externally or use default values.
    -   Additional local variables like `dcl_class` are not shown in the provided snippet but would typically be used for further customization within the template file.

2.  **Tags**:

    -   A map of custom tags (`custom_tags`) is merged with predefined global tags and additional metadata (e.g., source version information). This helps in resource management and tagging across different cloud providers or environments.

3.  **Outputs**:

    -   An output named `locals` provides a useful set of local variables that can be reused in other modules, enhancing code reuse and maintainability.

4.  **Variables**:
    -   `custom_name`: A string variable that allows setting a custom name for the deployment. It has a default value but can be overridden.

This script is crucial for maintaining consistency across different deployments by centralizing configuration settings in one place, making it easier to manage and update as needed.

### outputs.tf

The purpose of the file `outputs.tf` is to define outputs that can be used by other parts of the infrastructure as code (IaC) configuration, such as Terraform files or other modules. Here's a breakdown of what each output does based on the provided content:

1.  **Output "tags"**:

-   Purpose: This output provides a map of tags that are based on input variables. These tags can be referred to in HCL (HashiCorp Configuration Language) files for resource management and organization.

2.  **Output "lc"**:

-   Purpose: This output returns the location code associated with the specified cloud region. The `local.location_code` map is used to fetch the appropriate code based on the value of `var.cloud_region`.

3.  **Output "name_prefix"**:

-   Purpose: This output provides the name prefix, which is a local variable stored in `local.locals`. It can be used to ensure consistency in naming conventions across different resources.

4.  **Output "dcl"**:

-   Purpose: This output returns an object containing the data classification class and level. The `local.dcl_class` map is indexed by `local.level` to fetch the appropriate class and level information.

5.  **Output "locals"**:

-   Purpose: This output provides a map of useful local variables that can be used within other modules or configurations, enhancing reusability and maintainability of the infrastructure code.

    variables.tf:  The provided Terraform code snippet defines a set of variables and their configurations within a Terraform module. These variables are designed to provide global configuration settings and custom tags for resources being deployed. Below is an explanation of each part of the code:

1.  **Config Object**:

    -   This section defines a variable named `config` which is an object containing various fields such as `prefix`, `environment`, `application`, `productive`, `customer`, `businessunit`, `project`, `costcenter`, and `owner`.
    -   The `validation` blocks ensure that certain conditions are met for each field:
        -   `environment` must be up to 3 characters long and contain only letters and numbers.
        -   `prefix` can be up to 5 characters long and contain only letters and numbers (or be empty).
        -   `application` must be up to 15 characters long and contain only letters, hyphens (`-`), and numbers.
    -   This object is used to provide mandatory information for resource deployment, ensuring proper tagging and categorization of resources.

2.  **Data Classification Levels (DCL)**:

    -   The `dcl` variable defines an object with three fields: `integrity`, `confidentiality`, and `availability`.
    -   Each field is optional and defaults to "normal" if not provided.
    -   Validation rules ensure that these fields can only be set to specific values ("normal", "high", or "very_high").
    -   This variable is used to determine the protection class of resources based on their data classification.

3.  **Custom Variables**:

    -   `custom_tags` is a map variable where keys and values are both strings. It defaults to null but can be provided with custom tags.
    -   `custom_name` is a string variable that defaults to an empty string. This allows for setting a custom name for the deployment, subject to validation rules ensuring it does not exceed 16 characters and contains only letters, hyphens (`-`), or numbers.
    -   `version_info` is a string variable that defaults to "n/a" and provides version information from the calling module, used for tagging purposes.

    The purpose of this Terraform code snippet is to provide a structured way to define global configurations and custom tags for resources in a consistent manner across different deployments or environments. This ensures proper resource management, compliance with organizational standards, and efficient deployment processes.

### versions.tf

The `versions.tf` file is used to specify the required versions of Terraform and its providers. This ensures that the Terraform code adheres to a specific version, which helps maintain consistency and compatibility across different environments. Here's what each part does:

-   `required_version = ">= 1.6"`: Specifies that the Terraform CLI must be at least version 1.6 or higher to execute this configuration. This ensures that all team members are using compatible versions of Terraform for consistency and stability.
-   `required_providers {}`: Reserved for specifying which providers (e.g., AWS, Azure) are required by the Terraform modules used in the project. Since there are no provider blocks specified here, it implies that this configuration does not yet depend on any external cloud providers or services.

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

<!-- BEGIN_PIKE_DOCS -->

## Permissions (Pike)

```hcl

```

<!-- END_PIKE_DOCS -->
