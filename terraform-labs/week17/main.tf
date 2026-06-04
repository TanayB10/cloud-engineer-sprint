terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1" # Your home working region
}

resource "aws_security_group" "state_test_sg" {
  name        = "bank-state-test-sg"
  description = "Temporary group used to analyze state architecture"
}
