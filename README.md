# Enterprise AWS Infrastructure using Terraform

A production-style AWS infrastructure project built using Terraform, Git and GitHub.

This project demonstrates how to provision, configure and manage AWS infrastructure using Infrastructure as Code principles.

The infrastructure currently includes a custom VPC, public subnet, Internet Gateway, public routing, Security Group, EC2 instance, automated NGINX deployment and remote Terraform state management.

---

## Project Objective

The objective of this project is to build secure, reusable and maintainable AWS infrastructure using Terraform.

The project is designed to demonstrate practical knowledge of:

- Terraform infrastructure provisioning
- AWS networking
- EC2 deployment
- Security Group configuration
- Automated server configuration
- Remote Terraform state management
- Terraform variables and validation
- Git feature branches
- GitHub pull requests
- Infrastructure documentation
- Terraform plan review and troubleshooting

---

## Architecture Overview

The current architecture contains:

- One custom AWS VPC
- One public subnet
- One Internet Gateway
- One public route table
- One route table association
- One Security Group
- One Amazon Linux 2023 EC2 instance
- NGINX installed automatically using EC2 User Data
- Remote Terraform state stored in Amazon S3

The public subnet routes internet traffic through the Internet Gateway.

The EC2 instance receives a public IP address and uses a Security Group that allows:

- SSH from one approved public IP address
- HTTP from the internet
- HTTPS from the internet
- All outbound traffic

---

## Technologies Used

- Amazon Web Services
- Terraform
- Amazon VPC
- Amazon EC2
- Amazon S3
- Amazon Linux 2023
- NGINX
- PowerShell
- Shell scripting
- Git
- GitHub
- Visual Studio Code

---

## AWS Resources

The Terraform configuration currently manages:

| Resource | Purpose |
|---|---|
| VPC | Provides an isolated network for the project |
| Public subnet | Hosts internet-accessible infrastructure |
| Internet Gateway | Provides internet access to the VPC |
| Public route table | Routes public traffic to the Internet Gateway |
| Route table association | Connects the public subnet to the public route table |
| Security Group | Controls inbound and outbound EC2 traffic |
| EC2 instance | Hosts the NGINX web server |
| S3 backend bucket | Stores Terraform state remotely |

---

## Automated Web Server Deployment

The EC2 instance is automatically configured through an EC2 User Data shell script.

During the instance's first startup, the script:

- Updates the operating system packages
- Installs NGINX
- Creates a custom project webpage
- Enables the NGINX service at startup
- Starts the NGINX service automatically

The script is stored separately from the Terraform configuration:

```text
scripts/install-nginx.sh
```

Terraform reads the script using:

```hcl
user_data = replace(
  file("${path.module}/../scripts/install-nginx.sh"),
  "\r\n",
  "\n"
)
```

The `replace()` function converts Windows CRLF line endings into Linux LF line endings before the script is sent to Amazon Linux.

The EC2 instance is configured with:

```hcl
user_data_replace_on_change = true
```

This tells Terraform to replace the instance when the User Data script changes.

![NGINX Web Server](screenshots/phase-15-nginx-browser.png)

---

## Terraform Configuration Structure

The Terraform configuration is organized into separate files.

```text
terraform/
├── backend.tf
├── locals.tf
├── main.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars.example
├── variables.tf
└── versions.tf
```

### File responsibilities

| File | Purpose |
|---|---|
| `backend.tf` | Configures the remote S3 backend |
| `locals.tf` | Stores reusable common tags |
| `main.tf` | Contains AWS data sources and resources |
| `outputs.tf` | Displays useful resource information |
| `provider.tf` | Configures the AWS provider |
| `terraform.tfvars.example` | Shows example environment values |
| `variables.tf` | Defines typed input variables and validation |
| `versions.tf` | Defines Terraform and provider version requirements |

---

## Input Variables

Hardcoded infrastructure values were moved into Terraform variables.

Examples include:

- AWS Region
- VPC CIDR
- Public subnet CIDR
- Availability Zone
- EC2 instance type
- EC2 key-pair name
- Allowed SSH CIDR
- Environment
- Project name
- Owner

Example:

```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
```

The EC2 resource uses the variable:

```hcl
instance_type = var.instance_type
```

This makes the project easier to maintain and reuse.

---

## Variable Validation

Terraform validation is used to prevent invalid CIDR values.

Example:

```hcl
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}
```

SSH access is restricted to a single IPv4 address using a `/32` CIDR.

```hcl
variable "allowed_ssh_cidr" {
  description = "Public IPv4 CIDR allowed to access the EC2 instance through SSH"
  type        = string

  validation {
    condition = (
      can(cidrhost(var.allowed_ssh_cidr, 0)) &&
      endswith(var.allowed_ssh_cidr, "/32")
    )

    error_message = "allowed_ssh_cidr must be a valid single-host CIDR ending in /32."
  }
}
```

---

## Reusable Common Tags

Common AWS tags are centralized in `locals.tf`.

```hcl
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    Owner       = var.owner
  }
}
```

The common tags are combined with resource-specific names using Terraform's `merge()` function.

```hcl
tags = merge(
  local.common_tags,
  {
    Name = "enterprise-vpc"
  }
)
```

This avoids repeating the same tags in every AWS resource.

---

## Remote Terraform State

Terraform state is stored remotely in an encrypted Amazon S3 bucket.

Backend configuration:

```hcl
terraform {
  backend "s3" {
    bucket       = "yogesh-terraform-state-620745274545"
    key          = "enterprise/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
```

### Remote state benefits

- State is not stored only on one local computer
- Infrastructure state is centrally available
- Encryption is enabled
- State locking reduces concurrent modification risks
- The project follows a more production-oriented workflow

The Terraform state file is not committed to GitHub.

---

## Local Variable File Strategy

The actual local variable file is:

```text
terraform/terraform.tfvars
```

This file contains environment-specific values such as the approved SSH public IP address.

It is excluded from Git using `.gitignore`.

A safe example file is included:

```text
terraform/terraform.tfvars.example
```

Users should copy the example file and create their own local `terraform.tfvars`.

Example:

```hcl
allowed_ssh_cidr = "203.0.113.10/32"
```

The example IP is only a documentation value and must be replaced with the user's actual public IP address.

---

## Security Practices

The project currently includes the following security practices:

- SSH is restricted to one approved public IPv4 address
- SSH uses a `/32` CIDR instead of `0.0.0.0/0`
- HTTP and HTTPS access are controlled through a Security Group
- AWS credentials are not stored in Terraform files
- The real `terraform.tfvars` file is excluded from Git
- Terraform state files are excluded from Git
- Private key files are excluded from Git
- Remote state is encrypted in Amazon S3
- Terraform state locking is enabled
- Terraform plans are reviewed before applying changes

---

## Terraform Validation

The following commands are executed before applying infrastructure changes:

```bash
terraform fmt -recursive
terraform validate
terraform plan
```

### Formatting

```bash
terraform fmt -recursive
```

This formats Terraform files according to the standard Terraform style.

### Validation

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

### Plan

```bash
terraform plan
```

Current result:

```text
No changes. Your infrastructure matches the configuration.
```

This confirms that the Terraform configuration matches the deployed AWS resources.

---

## Important Troubleshooting

### Duplicate required providers configuration

Terraform validation initially returned:

```text
Error: Duplicate required providers configuration
```

The `required_providers` block existed in both:

```text
versions.tf
```

and:

```text
provider.tf
```

The final configuration keeps version requirements in `versions.tf`.

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

The AWS provider configuration remains in `provider.tf`.

```hcl
provider "aws" {
  region = var.aws_region
}
```

This resolved the duplicate provider configuration error.

### Preventing Security Group replacement

The first Terraform plan showed:

```text
Plan: 1 to add, 1 to change, 1 to destroy.
```

Terraform planned to replace the Security Group because its description had changed.

The changed description was:

```text
Security group for the EC2 web server
```

The existing description was:

```text
Security Group for Web Server
```

The Security Group description is a replacement-triggering property.

The original description and rule descriptions were restored.

The final result was:

```text
No changes. Your infrastructure matches the configuration.
```

This demonstrated the importance of reviewing Terraform plans before applying changes.

---

## Project Progress

- ✅ AWS CLI authentication and IAM setup
- ✅ Terraform initialization
- ✅ Custom VPC
- ✅ Public subnet
- ✅ Internet Gateway
- ✅ Public route table
- ✅ Route table association
- ✅ Security Group with restricted SSH access
- ✅ EC2 instance deployment
- ✅ Amazon Linux 2023 AMI selection
- ✅ Automated NGINX installation using EC2 User Data
- ✅ Custom webpage deployment
- ✅ Remote Terraform state using Amazon S3
- ✅ S3 state encryption
- ✅ S3 state locking using `use_lockfile`
- ✅ Terraform input variables
- ✅ Terraform variable validation
- ✅ Terraform local values
- ✅ Reusable common AWS tags
- ✅ `terraform.tfvars.example`
- ✅ Terraform configuration refactoring
- ✅ Terraform no-change plan verification
- ✅ Git feature-branch workflow
- ✅ GitHub documentation
- ⏳ Terraform modules
- ⏳ GitHub Actions CI pipeline
- ⏳ Additional infrastructure security improvements
- ⏳ Monitoring and alerting
- ⏳ Final architecture diagram

---

## Latest Implementation

### Phase 15 — Terraform Configuration Refactoring

The Terraform configuration was refactored to improve maintainability and reusability without changing the deployed AWS infrastructure.

The phase included:

- Replacing hardcoded values with input variables
- Adding CIDR validation
- Centralizing common tags through Terraform locals
- Applying tags using `merge()`
- Separating provider requirements and provider configuration
- Adding a safe example variable file
- Resolving duplicate provider configuration
- Preventing unnecessary Security Group replacement
- Confirming a no-change Terraform plan

Final result:

```text
No changes. Your infrastructure matches the configuration.
```

[View Phase 15 implementation details](docs/15-terraform-configuration-refactoring.md)

---

## Repository Structure

```text
enterprise-aws-infrastructure/
├── docs/
│   └── 15-terraform-configuration-refactoring.md
├── screenshots/
│   ├── phase-15-nginx-browser.png
│   ├── phase-15-plan-no-changes.png
│   ├── phase-15-terraform-validate.png
│   └── phase-15-variables-locals.png
├── scripts/
│   └── install-nginx.sh
├── terraform/
│   ├── backend.tf
│   ├── locals.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── terraform.tfvars.example
│   ├── variables.tf
│   └── versions.tf
├── .gitignore
└── README.md
```

The following files are intentionally excluded from Git:

```text
terraform.tfvars
*.tfstate
*.tfstate.*
.terraform/
*.pem
*.key
```

---

## Key Learning Outcomes

Through this project, I practiced:

- Terraform infrastructure provisioning
- AWS VPC networking
- Public subnet design
- Internet Gateway configuration
- Route table configuration
- Security Group rules
- EC2 instance deployment
- Amazon Linux 2023 AMI selection
- NGINX deployment using User Data
- Terraform remote state management
- Terraform variables
- Terraform variable validation
- Terraform locals
- Terraform `merge()` function
- State locking
- Terraform formatting and validation
- Terraform execution plan review
- Resource replacement analysis
- Git branches
- GitHub pull requests
- Infrastructure documentation

---

---

## Future Enhancements

Planned improvements include:

- Convert Terraform resources into reusable modules
- Add separate development and production environments
- Add GitHub Actions for Terraform validation
- Add `terraform fmt` and `terraform validate` checks in CI
- Add Checkov or Trivy infrastructure scanning
- Add CloudWatch monitoring
- Improve EC2 security
- Add an Application Load Balancer when cost permits
- Add Auto Scaling when cost permits
- Complete the final architecture diagram

---

## Author

**Yogesh**

GitHub: [YogeshS-Mca](https://github.com/YogeshS-Mca)