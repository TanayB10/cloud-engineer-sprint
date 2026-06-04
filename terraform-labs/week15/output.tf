output "vpc_id" {
  value       = aws_vpc.dynamic_bank_vpc.id
  description = "The generated tracking ID of the custom VPC"
}

output "subnet_id" {
  value       = aws_subnet.dynamic_subnet.id
  description = "The generated tracking ID of the public subnet"
}
