provider "aws" {
  region = var.region
}

resource "aws_vpc" "my_custom_vpc" {
  cidr_block = var.vpc_cidr_block_address
  tags = {
    Name = "my_custom_vpc_made_with_terraform"
  }
  enable_dns_hostnames = true
  enable_dns_support = true
}
 
resource "aws_internet_gateway" "my_custom_itg" {
  vpc_id = aws_vpc.my_custom_vpc.id
  tags = {
    Name : "My custom Internet Gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_custom_itg.id
  }

  tags = {
    Name : "Public Route Table"
  }
}

resource "aws_subnet" "public_subnet_A" {
  cidr_block              = var.public_subnet_a_cidr_block
  vpc_id                  = aws_vpc.my_custom_vpc.id
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = true

  tags = {
    "Name" = "Public Subnet A"
  }
}

resource "aws_subnet" "public_subnet_B" {
  cidr_block              = var.public_subnet_b_cidr_block
  vpc_id                  = aws_vpc.my_custom_vpc.id
  availability_zone       = var.availability_zone_b
  map_public_ip_on_launch = true

  tags = {
    "Name" = "Public Subnet B"
  }
}

resource "aws_route_table_association" "public_subnet_association_with_route_table_a" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_A.id
}
resource "aws_route_table_association" "public_subnet_association_with_route_table_b" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_B.id
}

