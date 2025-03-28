output "public-ip-ec2-instance" {
  value = aws_instance.apache-server.public_ip
}