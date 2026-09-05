output "instance_id" {
  description = "Netflix EC2 instance ID"
  value       = aws_instance.netflix.id
}

output "public_ip" {
  description = "Public IP of Netflix EC2"
  value       = aws_instance.netflix.public_ip
}

output "private_ip" {
  description = "Private IP of Netflix EC2"
  value       = aws_instance.netflix.private_ip
}
