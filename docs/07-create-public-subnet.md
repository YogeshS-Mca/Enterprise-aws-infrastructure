# Phase 10 - Create Public Subnet

## Objective

Create a public subnet inside the custom VPC using Terraform.

## Why is a subnet required?

A subnet divides a VPC into smaller networks, allowing resources to be organized based on their purpose and security requirements.

## Configuration

- VPC: enterprise-vpc
- CIDR: 10.0.1.0/24
- Availability Zone: ap-south-1a
- Auto-assign Public IP: Enabled

## Commands Used

terraform validate
terraform fmt
terraform plan
terraform apply

## Learning Outcome

- Understood the relationship between a VPC and a subnet.
- Learned how Terraform references one resource from another using `aws_vpc.main.id`.
- Successfully created a public subnet.