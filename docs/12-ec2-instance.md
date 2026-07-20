# Phase 12 - EC2 Instance

## Objective

Launch an Amazon EC2 instance using Terraform.

---

## What is EC2?

Amazon EC2 (Elastic Compute Cloud) is a virtual server in AWS.

It allows users to deploy applications without managing physical hardware.

---

## Business Problem

Applications require compute resources to run.

Instead of purchasing physical servers, organizations use EC2 instances because they are scalable, reliable, and cost-effective.

---

## Business Scenario

A company wants to host a web application.

The application will run on an EC2 instance inside a Public Subnet.

The server will be protected using a Security Group and accessed securely using SSH.

---

## Expected Result

- Launch EC2 Instance
- Associate Security Group
- Deploy inside Public Subnet
- Assign Public IP
- Connect using SSH

---

## Learning Outcome

- Learned EC2 fundamentals
- Learned Terraform EC2 deployment
- Understood networking and Security Group integration