# Phase 2 - Creating an IAM User for Terraform

## Overview

Before Terraform can create AWS resources, it must authenticate with AWS. Instead of using the AWS root account, I created a dedicated IAM user for Terraform. This follows AWS security best practices and keeps the root account protected.

---

## Why I Created an IAM User

Terraform communicates with AWS by making API requests. AWS verifies every request before allowing any resource to be created, modified, or deleted.

To authenticate those requests, Terraform requires AWS credentials. Rather than using the root account, I created a separate IAM user named `terraform-user`.

This approach improves security and is the recommended method used in production environments.

---

## What I Did

- Opened the AWS Management Console.
- Navigated to the IAM service.
- Created a new user named `terraform-user`.
- Attached the `AdministratorAccess` policy for learning purposes.
- Generated an Access Key and Secret Access Key.
- Stored the credentials securely for AWS CLI configuration.

---

## What Happened Behind the Scenes

When the access key was generated, AWS created two credentials:

- Access Key ID
- Secret Access Key

Whenever Terraform or the AWS CLI sends a request, AWS checks these credentials to verify my identity. If the credentials are valid and have the required permissions, AWS processes the request.

---

## Why I Didn't Use the Root Account

The root account has full control over the AWS account and should only be used for account-level tasks.

Using an IAM user provides:

- Better security
- Easier access management
- User-level activity tracking
- Reduced risk if credentials are compromised

---

## Result

I successfully created a dedicated IAM user that will be used by Terraform and the AWS CLI to authenticate with AWS.

---

## Key Learning

During this step, I learned:

- What IAM is
- Why IAM users are preferred over the root account
- How AWS authentication works
- How Terraform securely connects to AWS

---

## Interview Question

**Why do you use an IAM user instead of the root account?**

The root account has unrestricted access and should be reserved for account administration. Creating a dedicated IAM user improves security, supports the principle of least privilege, and follows AWS best practices for day-to-day operations and automation.