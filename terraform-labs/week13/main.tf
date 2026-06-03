# 1. Define the Cloud Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1" # Or your preferred working European region (e.g., eu-central-1)
}

# 2. Declare the Infrastructure Resource
resource "aws_s3_bucket" "bank_storage" {
  bucket = "tanay-unique-bank-bucket-2026"

  tags = {
    Name        = "Bank Storage Bucket"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
