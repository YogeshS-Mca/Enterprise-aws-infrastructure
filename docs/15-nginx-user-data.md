# Phase 15 - Automated NGINX Deployment

## Overview

In this phase, I automated the configuration of the EC2 web server using Terraform and EC2 User Data.

Previously, the EC2 instance was provisioned successfully, but software installation required manual SSH access. I improved the deployment by adding a startup script that automatically installs NGINX, creates a custom webpage, and enables the service.

## Business Problem

Manually configuring every newly launched server is slow and can produce inconsistent results.

Infrastructure provisioning alone is not sufficient if application dependencies must still be installed manually.

## Solution

I used EC2 User Data to bootstrap the Amazon Linux instance during its first startup.

The script performs the following actions:

1. Updates the system packages.
2. Installs NGINX.
3. Creates a custom project webpage.
4. Starts the NGINX service.
5. Enables NGINX after reboot.
6. Records execution logs for troubleshooting.

## Why I Used a Separate Script

I stored the startup logic in:

```text
scripts/install-nginx.sh
```

Keeping the script separate from `main.tf` improves:

- Readability
- Maintainability
- Testing
- Version control
- Reusability

## Terraform Configuration

```hcl
user_data = file("${path.module}/../scripts/install-nginx.sh")
user_data_replace_on_change = true
```

## Deployment Commands

```bash
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Verification

I verified the deployment by:

- Opening the EC2 public IP in a web browser.
- Checking the NGINX service status.
- Running `curl http://localhost`.
- Reviewing `/var/log/user-data.log`.
- Checking cloud-init status.

## Result

The EC2 instance automatically configured itself as an NGINX web server during startup.

## Troubleshooting Knowledge

User Data normally runs during the first boot. When troubleshooting, I checked:

```bash
sudo cloud-init status --long
sudo cat /var/log/user-data.log
sudo journalctl -u nginx
```

## Key Learning

- Automated server bootstrapping with User Data.
- Used cloud-init for initial configuration.
- Removed manual installation steps.
- Learned how to debug startup scripts.
- Created Terraform outputs for operational information.