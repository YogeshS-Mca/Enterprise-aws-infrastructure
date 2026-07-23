#######################################################
# AWS Region
#######################################################

variable "aws_region" {
  description = "AWS Region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

#######################################################
# Network Configuration
#######################################################

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"

  validation {
    condition     = can(cidrhost(var.public_subnet_cidr, 0))
    error_message = "public_subnet_cidr must be a valid CIDR block."
  }
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  type        = string
  default     = "ap-south-1a"
}

#######################################################
# EC2 Configuration
#######################################################

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing EC2 Key Pair name"
  type        = string
  default     = "enterprise-key"
}

#######################################################
# SSH Configuration
#######################################################

variable "allowed_ssh_cidr" {
  description = "Public IPv4 CIDR allowed to access the EC2 instance through SSH"
  type        = string

  validation {
    condition = (
      can(cidrhost(var.allowed_ssh_cidr, 0)) &&
      endswith(var.allowed_ssh_cidr, "/32")
    )

    error_message = "allowed_ssh_cidr must be a valid single-host CIDR ending in /32 (Example: 203.0.113.10/32)."
  }
}

#######################################################
# Common Tags
#######################################################

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "Learning"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "Enterprise AWS Infrastructure"
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
  default     = "Yogesh"
}