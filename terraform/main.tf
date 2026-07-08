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