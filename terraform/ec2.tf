resource "aws_instance" "apache-server" {
  ami             = "ami-0e35ddab05955cf57"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public-sub.id
  security_groups = [aws_security_group.new-security-group.id]
  key_name        = "linux-01"

  tags = {
    Name = "apache-server-latest"
  }
}