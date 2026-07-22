variable "allowed_ssh_cidr" {
  description = "Public IPv4 CIDR allowed to access the EC2 instance through SSH"
  type        = string

  validation {
    condition = (
      can(cidrhost(var.allowed_ssh_cidr, 0)) &&
      endswith(var.allowed_ssh_cidr, "/32")
    )

    error_message = "allowed_ssh_cidr must be a valid single-host CIDR ending in /32, for example 203.0.113.10/32."
  }
}

variable "aws_region" {
  description = "AWS Region where resources will be created"
  type        = string
  default     = "ap-south-1"
}