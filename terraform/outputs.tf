output "vpc_id" {
  description = "ID of the Enterprise VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the Public Subnet"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the Web Server Security Group"
  value       = aws_security_group.web_sg.id
}

output "ec2_instance_id" {
  description = "ID of the EC2 Web Server"
  value       = aws_instance.web.id
}

output "ec2_public_ip" {
  description = "Public IPv4 address of the EC2 Web Server"
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "URL for accessing the NGINX website"
  value       = "http://${aws_instance.web.public_ip}"
}

output "ssh_command" {
  description = "Example SSH command for connecting to the server"
  value       = "ssh -i enterprise-key.pem ec2-user@${aws_instance.web.public_dns}"
}