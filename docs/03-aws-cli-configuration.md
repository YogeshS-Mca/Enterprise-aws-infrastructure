# Phase 3 - Configuring AWS CLI

## Overview

The AWS Command Line Interface (AWS CLI) allows me to interact with AWS services directly from my local computer.

Terraform uses the credentials configured in AWS CLI to authenticate with AWS.

---

## Why AWS CLI?

AWS CLI provides a secure and convenient way to authenticate applications such as Terraform.

Instead of entering credentials inside the Terraform code, AWS CLI stores them securely on the local machine.

---

## Commands Used

```bash
aws configure
aws configure list
aws sts get-caller-identity
```

---

## Expected Result

AWS CLI should authenticate successfully and display the IAM user details using the `aws sts get-caller-identity` command.

---

## Learning Outcome

- Understood the purpose of AWS CLI.
- Learned how Terraform authenticates with AWS.
- Verified AWS authentication successfully.