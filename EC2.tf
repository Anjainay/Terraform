
resource "aws_instance" "web" {
  ami           = "ami-0fa3fe0fa7920f68e" # Amazon Linux 2 (ap-south-1)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from Terraform EC2" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-server"
  }
}

resource "aws_instance" "web1" {
  ami           = "ami-0fa3fe0fa7920f68e" # Amazon Linux 2 (ap-south-1)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from Terraform EC2" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-server"
  }
}
