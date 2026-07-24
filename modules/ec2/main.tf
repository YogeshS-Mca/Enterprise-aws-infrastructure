#######################################################
# Common Tags
#######################################################

locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    Owner       = var.owner
  }
}

#######################################################
# EC2 Instance
#######################################################

resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = var.user_data

  user_data_replace_on_change = true

  tags = merge(
    local.common_tags,
    {
      Name = "enterprise-web-server"
    }
  )
}