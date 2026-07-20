# Phase 11 - Security Group

## Objective

Create a Security Group using Terraform to control network access to EC2 instances deployed inside the Public Subnet.

---

# Business Problem

Every server connected to the internet must be protected from unauthorized access.

Without a firewall, anyone on the internet could attempt to connect to the server, increasing security risks.

AWS provides Security Groups to control which inbound and outbound traffic is allowed.

---

# Why Security Groups?

A Security Group acts as a virtual firewall for AWS resources.

It allows only approved network traffic to reach the EC2 instance while blocking everything else.

In this project, the Security Group allows:

- SSH (22) for secure administration
- HTTP (80) for website access
- HTTPS (443) for secure website access

---

# Business Scenario

Imagine a company hosts its website on an EC2 instance.

Customers should be able to access the website over HTTP and HTTPS.

Only the system administrator should be able to connect to the server using SSH.

To achieve this, a Security Group is created with appropriate inbound and outbound rules.

---

# Terraform Resource

```hcl
resource "aws_security_group" "web_sg" {

  name        = "enterprise-web-sg"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["157.50.189.58/32"]
  }

  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "enterprise-web-sg"
    Environment = "Learning"
    Project     = "Enterprise AWS Infrastructure"
    Owner       = "Yogesh"
  }
}
```

---

# Commands Executed

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

# Result

The Security Group was successfully created and attached to the VPC.

Configured inbound rules:

- SSH (22) from my public IP
- HTTP (80) from anywhere
- HTTPS (443) from anywhere

Configured outbound rule:

- Allow all outbound traffic

---

# AWS Console Verification

After applying Terraform:

AWS Console

→ VPC

→ Security Groups

Verified:

- Security Group Name
- Inbound Rules
- Outbound Rules
- VPC Association

---

# Screenshot

![Security Group](../screenshots/phase-11-security-group.png)

---

# Key Learning

- Learned how Security Groups work in AWS.
- Understood inbound and outbound rules.
- Learned why SSH should be restricted to a specific IP.
- Understood how Security Groups protect EC2 instances.

---

# Interview Questions

## What is a Security Group?

A Security Group is a stateful virtual firewall that controls inbound and outbound traffic for AWS resources such as EC2 instances.

---

## Why did you allow SSH only from your public IP?

Restricting SSH access to a single public IP improves security by preventing unauthorized access from other internet users.

---

## Difference between Security Group and Network ACL

| Security Group | Network ACL |
|---------------|-------------|
| Stateful | Stateless |
| Instance Level | Subnet Level |
| Supports Allow Rules Only | Supports Allow and Deny Rules |

---

# Project Status

Completed:

- Git & GitHub Setup
- IAM User
- AWS CLI Configuration
- Terraform Setup
- Amazon VPC
- Public Subnet
- Internet Gateway
- Route Table
- Route Table Association
- Security Group

