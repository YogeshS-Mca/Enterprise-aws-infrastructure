variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  type        = string
}

variable "environment" {
  description = "Environment tag value"
  type        = string
}

variable "project_name" {
  description = "Project tag value"
  type        = string
}

variable "owner" {
  description = "Owner tag value"
  type        = string
}