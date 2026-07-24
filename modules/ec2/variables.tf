#######################################################
# EC2 Module Variables
#######################################################

variable "ami_id" {
  description = "AMI ID used to launch the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID attached to the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair used for SSH access"
  type        = string
}

variable "user_data" {
  description = "Bootstrap script executed when the EC2 instance starts"
  type        = string
}

variable "environment" {
  description = "Deployment environment name"
  type        = string
}

variable "project_name" {
  description = "Project name used in resource tags"
  type        = string
}

variable "owner" {
  description = "Owner name used in resource tags"
  type        = string
}