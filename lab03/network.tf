resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "lab_subnet_a" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "lab_subnet_b" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id
}