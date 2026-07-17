# Phase 12 - Deploy Infrastructure to New AWS Account

## Objective

Redeploy the existing Terraform infrastructure into a new AWS account after the previous account was closed.

## Resources Created

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Route Table Association

## Commands Executed

terraform init

terraform validate

terraform fmt

terraform plan

terraform apply

## Result

Successfully recreated the networking infrastructure in the new AWS account.

## Learning Outcome

- Learned how to migrate Terraform deployments to a different AWS account.
- Verified that Infrastructure as Code can be reused without rewriting the project.