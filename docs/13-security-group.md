# Phase 13 - Create Security Group

## Objective

Create a Security Group to protect the EC2 instance by controlling inbound and outbound traffic.

## Why is a Security Group Needed?

A Security Group acts as a virtual firewall for EC2 instances. It allows only approved network traffic to reach the server while blocking unauthorized access.

## Rules Configured

### Inbound Rules

| Port | Protocol | Purpose | Source |
|------|----------|---------|--------|
| 22 | TCP | SSH | My Public IP |
| 80 | TCP | HTTP | Anywhere |
| 443 | TCP | HTTPS | Anywhere |

### Outbound Rules

Allow all outbound traffic to the internet.

## Learning Outcome

- Learned how Security Groups work.
- Restricted SSH access to a trusted public IP.
- Allowed HTTP and HTTPS for web traffic.
- Applied AWS security best practices.