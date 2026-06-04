output "public_ip" {
  value       = aws_instance.bank_web_server.public_ip
  description = "The public IPv4 address of the web node"
}

output "web_url" {
  value       = "http://${aws_instance.bank_web_server.public_ip}"
  description = "The web portal link"
}
