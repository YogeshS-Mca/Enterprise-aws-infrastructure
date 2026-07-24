#######################################################
# Network Module
#######################################################

module "network" {
  source = "../modules/network"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  environment        = var.environment
  project_name       = var.project_name
  owner              = var.owner
}

#######################################################
# Security Group Module
#######################################################

module "security_group" {
  source = "../modules/security-group"

  vpc_id           = module.network.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
  environment      = var.environment
  project_name     = var.project_name
  owner            = var.owner
}

#######################################################
# EC2 Module
#######################################################

module "ec2" {
  source = "../modules/ec2"

  ami_id            = "ami-003957db306374bc5"
  instance_type     = var.instance_type
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security_group.security_group_id
  key_name          = var.key_name

  user_data = replace(
    file("${path.module}/../scripts/install-nginx.sh"),
    "\r\n",
    "\n"
  )

  environment  = var.environment
  project_name = var.project_name
  owner        = var.owner
}