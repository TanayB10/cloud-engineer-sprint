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

# Dynamic VPC
resource "aws_vpc" "dynamic_bank_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "bank-${var.environment_tag}-vpc"
    Environment = var.environment_tag
  }
}

# Dynamic Subnet
resource "aws_subnet" "dynamic_subnet" {
  vpc_id            = aws_vpc.dynamic_bank_vpc.id
  cidr_block        = var.subnet_cidr

  tags = {
    Name = "bank-${var.environment_tag}-public-subnet"
  }
}
