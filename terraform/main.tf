##EC2

data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}


resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "enterprise-vpc"
    Environment = "Learning"
    Project     = "Enterprise AWS Infrastructure"
    Owner       = "Yogesh"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet"
    Environment = "Learning"
    Project     = "Enterprise AWS Infrastructure"
  }
}

####Route table

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "public-route-table"
    Environment = "Learning"
    Project     = "Enterprise AWS Infrastructure"
    Owner       = "Yogesh"
  }
}

resource "aws_route_table_association" "public" {

  subnet_id = aws_subnet.public.id

  route_table_id = aws_route_table.public.id

}

###AWS INTERNET GATEWAY

resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "enterprise-igw"
    Environment = "Learning"
    Project     = "Enterprise AWS Infrastructure"
    Owner       = "Yogesh"
  }
}

####

resource "aws_security_group" "web_sg" {

  name        = "enterprise-web-sg"
  description = "Security Group for Web Server"
  vpc_id      = aws_vpc.main.id

  # SSH Access (Only from your public IP)
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [
      "152.57.25.225/32"
    ]
  }

  # HTTP Access (Allow everyone)
  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # HTTPS Access (Allow everyone)
  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # Outbound Traffic
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name        = "enterprise-web-sg"
    Environment = "Learning"
    Project     = "Enterprise AWS Infrastructure"
    Owner       = "Yogesh"
  }
}