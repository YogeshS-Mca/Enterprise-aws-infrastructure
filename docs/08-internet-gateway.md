# Phase 11 - Internet Gateway

## Objective

Create and attach an Internet Gateway to the custom VPC.

---

## What is an Internet Gateway?

An Internet Gateway (IGW) allows communication between a VPC and the public Internet.

Without an Internet Gateway, resources inside the VPC cannot communicate with the Internet even if they have public IP addresses.

---

## Business Scenario

Imagine an organization hosting a public website.

Customers from around the world need to access the web server.

The Internet Gateway acts as the entry and exit point for Internet traffic.

---

## Expected Result

- Internet Gateway created
- Attached to Enterprise VPC
- Ready for Route Table configuration

---

## Learning Outcome

- Understood the purpose of an Internet Gateway.
- Learned why a VPC requires an IGW for Internet connectivity.

## Terraform Implementation

Created an Internet Gateway using Terraform.

Resource:

aws_internet_gateway

Purpose:

Provides communication between the VPC and the public internet.

## Validation

Commands executed:

terraform fmt

terraform validate

terraform plan

terraform apply

## Result

Internet Gateway successfully created and attached to Enterprise VPC.