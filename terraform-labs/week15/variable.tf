variable "aws_region" {
  type        = string
  description = "The target AWS Region for deployment"
  default     = "eu-north-1"
}

variable "vpc_cidr" {
  type        = string
  description = "The base IP range for the custom VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "The IP range for the public web subnet"
  default     = "10.0.1.0/24"
}

variable "environment_tag" {
  type        = string
  description = "Deployment stage tracking tag"
  default     = "Staging"
}
