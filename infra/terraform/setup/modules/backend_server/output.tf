output "backend_server_public_ip" {
  value = aws_instance.sample_ec2_instance.public_ip
}