variable "aws_region" {
  type        = string
  description = "Target deployment data center region"
  default     = "eu-north-1"
}

variable "instance_type" {
  type        = string
  description = "Hardware compute sizing for the web tier"
  default     = "t3.micro"
}

variable "env_tag" {
  type        = string
  description = "Deployment environment tracking metric"
  default     = "Production"
}
