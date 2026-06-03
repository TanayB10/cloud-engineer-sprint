# 1. Define Terraform and the AWS Provider Ecosystem
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1" # Swap this to your preferred home region (e.g., eu-central-1)
}

# 2. Build the Core Virtual Private Cloud (VPC)
resource "aws_vpc" "bank_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name        = "bank-automated-vpc"
    Environment = "Production"
  }
}

# 3. Create the Public Web Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.bank_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "bank-public-subnet"
  }
}

# 4. Attach the Internet Gateway (The Front Door)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.bank_vpc.id

  tags = {
    Name = "bank-igw"
  }
}

# 5. Formulate the Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.bank_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "bank-public-route-table"
  }
}

# 6. Associate the Route Table to the Subnet (Unlocking Internet Traffic)
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 7. Create the Security Group (The Infrastructure Firewall)
resource "aws_security_group" "web_sg" {
  name        = "bank-automated-web-sg"
  description = "Allow inbound HTTP and SSH traffic"
  vpc_id      = aws_vpc.bank_vpc.id

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bank-automated-sg"
  }
}
