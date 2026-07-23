#######################################################
# Latest Amazon Linux 2023 AMI
#######################################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

#######################################################
# VPC
#######################################################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = "enterprise-vpc"
    }
  )
}

#######################################################
# Public Subnet
#######################################################

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "public-subnet"
    }
  )
}

#######################################################
# Internet Gateway
#######################################################

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "enterprise-igw"
    }
  )
}

#######################################################
# Public Route Table
#######################################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "public-route-table"
    }
  )
}

#######################################################
# Route Table Association
#######################################################

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

#######################################################
# Security Group
#######################################################

resource "aws_security_group" "web_sg" {
  name        = "enterprise-web-sg"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.main.id

  # SSH access only from the IP supplied through terraform.tfvars
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  # HTTP access from anywhere
  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "enterprise-web-sg"
    }
  )
}

#######################################################
# EC2 Instance
#######################################################

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  # Normalize Windows CRLF line endings to Linux LF
  user_data = replace(
    file("${path.module}/../scripts/install-nginx.sh"),
    "\r\n",
    "\n"
  )

  # Replace the EC2 instance when the user-data script changes
  user_data_replace_on_change = true

  tags = merge(
    local.common_tags,
    {
      Name = "enterprise-web-server"
    }
  )
}