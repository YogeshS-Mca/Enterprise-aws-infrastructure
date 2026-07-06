# Phase 6 - Terraform Initialization

## Overview

Before Terraform can create infrastructure, it must initialize the working directory. This step downloads the required provider plugins and prepares Terraform for future operations.

---

## Commands Executed

```bash
cd terraform
terraform init
terraform providers
```

---

## What Happened

- Terraform read the configuration files.
- It identified the required AWS provider.
- It downloaded the provider plugin.
- It created the `.terraform` directory.
- It generated the `.terraform.lock.hcl` file.

---

## Files Created

### `.terraform`

Stores downloaded provider plugins and Terraform's working data.

### `.terraform.lock.hcl`

Locks the provider version to ensure consistent deployments across different systems.

---

## Learning Outcome

- Learned the purpose of `terraform init`.
- Understood how Terraform downloads provider plugins.
- Learned why the lock file is important.