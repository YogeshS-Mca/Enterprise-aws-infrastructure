# Phase 15 — Terraform Configuration Refactoring

## Objective

Refactor the existing Terraform configuration to reduce hardcoded values, improve reusability and centralize common tags without changing the deployed AWS infrastructure.

## Existing Problem

The initial Terraform configuration contained repeated values such as:

- AWS Region
- VPC CIDR
- Public subnet CIDR
- Availability Zone
- EC2 instance type
- EC2 key-pair name
- Environment tag
- Project tag
- Owner tag

Repeating these values in multiple resources makes the configuration harder to maintain and reuse.

## Solution Implemented

The Terraform code was improved using:

- Typed input variables
- Variable validation
- Terraform local values
- The `merge()` function
- Separate provider and version configuration
- A safe example variable file
- Terraform formatting, validation and planning

## Input Variables

Hardcoded infrastructure values were moved into `variables.tf`.

Example:

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
```

The EC2 resource now uses:

```hcl
instance_type = var.instance_type
```

This makes the configuration easier to reuse across different environments.

## CIDR Validation

Validation was added for network CIDR variables.

```hcl
validation {
  condition     = can(cidrhost(var.vpc_cidr, 0))
  error_message = "vpc_cidr must be a valid CIDR block."
}
```

SSH access is restricted to a single public IPv4 address using a `/32` CIDR.

```hcl
validation {
  condition = (
    can(cidrhost(var.allowed_ssh_cidr, 0)) &&
    endswith(var.allowed_ssh_cidr, "/32")
  )

  error_message = "allowed_ssh_cidr must be a valid single-host CIDR ending in /32."
}
```

## Common Tags

Common tags were centralized in `locals.tf`.

```hcl
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    Owner       = var.owner
  }
}
```

These tags are reused across AWS resources.

## Using `merge()`

The Terraform `merge()` function combines common tags with a resource-specific `Name` tag.

```hcl
tags = merge(
  local.common_tags,
  {
    Name = "enterprise-vpc"
  }
)
```

This reduces repeated code and maintains consistent tags.

## Provider Organization

Terraform version and provider requirements are stored in `versions.tf`.

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

AWS provider configuration is stored separately in `provider.tf`.

```hcl
provider "aws" {
  region = var.aws_region
}
```

## Troubleshooting Duplicate Provider Configuration

During validation, Terraform returned:

```text
Error: Duplicate required providers configuration
```

The `required_providers` block existed in both `versions.tf` and `provider.tf`.

The duplicate block was removed from `provider.tf`, leaving:

```hcl
provider "aws" {
  region = var.aws_region
}
```

This resolved the validation error.

## Preventing Security Group Replacement

The initial Terraform plan showed:

```text
Plan: 1 to add, 1 to change, 1 to destroy.
```

Terraform planned to replace the Security Group because its description had been changed.

The original Security Group description and rule descriptions were restored.

This prevented unnecessary resource replacement.

## Variable File Strategy

The real variable file remains excluded from Git:

```text
terraform/terraform.tfvars
```

A safe example file was added:

```text
terraform/terraform.tfvars.example
```

This allows other users to configure the project without exposing environment-specific values.

## Validation Commands

```bash
terraform fmt -recursive
terraform validate
terraform plan
```

## Final Result

```text
No changes. Your infrastructure matches the configuration.
```

Terraform compared the deployed AWS infrastructure with the code and found no differences.

## Infrastructure Impact

- 0 resources added
- 0 resources changed
- 0 resources destroyed
- No AWS resource replacement
- No additional AWS cost introduced

## Key Learning

A Terraform refactoring task should always be verified using `terraform plan`.

Even a small configuration change, such as changing a Security Group description, can cause resource replacement.

Reviewing the plan before applying prevented an unnecessary destroy-and-recreate operation.
