output "instance_public_ip" {
  description = "Public IP of the EC2 web server"
  value       = aws_instance.Cloup-Ops_web-server.public_ip
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.Cloup-Ops_web-server.id
}