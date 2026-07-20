# Phase 12 - Create EC2 Instance

## Objective

Launch an Amazon EC2 instance using Terraform inside the public subnet.

## Why do we need an EC2 Instance?

An EC2 instance is a virtual server in AWS. It allows us to run applications, host websites, install software like NGINX, and connect securely using SSH.

## Resources Used

- Amazon Linux 2023 AMI
- t3.micro instance
- Public Subnet
- Security Group
- Internet Gateway
- Route Table
- Key Pair (enterprise-key)

## Terraform Resources

- aws_instance
- data.aws_ami

## Learning Outcome

- Learned what an EC2 instance is.
- Used a dynamic AMI lookup.
- Attached a Security Group.
- Used a Key Pair for SSH access.
- Deployed an EC2 instance with Terraform.