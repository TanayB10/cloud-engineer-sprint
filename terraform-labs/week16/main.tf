terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Dynamic AMI Data Source: Resolves the latest verified AL2023 release for your active region
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# 1. Virtual Private Cloud (VPC)
resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "bank-${var.env_tag}-vpc"
  }
}

# 2. Public Communication Subnet
resource "aws_subnet" "prod_subnet" {
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "bank-${var.env_tag}-public-subnet"
  }
}

# 3. Edge Internet Gateway
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "bank-${var.env_tag}-igw"
  }
}

# 4. Routing Table Architecture
resource "aws_route_table" "prod_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }

  tags = {
    Name = "bank-${var.env_tag}-public-rt"
  }
}

# 5. Route Table Binding
resource "aws_route_table_association" "prod_assoc" {
  subnet_id      = aws_subnet.prod_subnet.id
  route_table_id = aws_route_table.prod_rt.id
}

# 6. Firewall Security Group
resource "aws_security_group" "prod_sg" {
  name        = "bank-${var.env_tag}-web-sg"
  description = "Allows incoming web and administration traffic"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 7. Automated EC2 Web Instance with Bootstrapping
resource "aws_instance" "bank_web_server" {
  ami                    = data.aws_ssm_parameter.al2023_ami.value # Dynamically mapped token reference
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.prod_subnet.id
  vpc_security_group_ids = [aws_security_group.prod_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              dnf install httpd -y
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Welcome to the Automated Bank Production Portal</h1><p>Provisioned flawlessly via Infrastructure as Code.</p>" > /var/log/httpd/index.html
              mv /var/log/httpd/index.html /var/www/html/index.html
              EOF

  tags = {
    Name        = "bank-${var.env_tag}-web-server"
    Environment = var.env_tag
  }
}
