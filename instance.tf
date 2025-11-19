# -----------------------------------------
# Security Group for Public EC2
# Allows SSH from anywhere (you can restrict later)
# -----------------------------------------
resource "aws_security_group" "public_sg" {
  name        = "public-ec2-sg"
  description = "Allow SSH to public instance"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # allow from anywhere; change later if needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-sg"
  }
}

# -----------------------------------------
# Security Group for Private EC2
# Only allows SSH from the Public EC2
# -----------------------------------------
resource "aws_security_group" "private_sg" {
  name        = "private-ec2-sg"
  description = "Allow SSH only from public instance"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "SSH from public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}

# -----------------------------------------
# EC2 Instance in Public Subnet
# -----------------------------------------
resource "aws_instance" "public_instance" {
  ami           = "ami-0fa3fe0fa7920f68e"   # <-- replace this with your AMI ID
  instance_type = "t3.micro"

  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true   # ensure public IP

  tags = {
    Name = "public-ec2"
  }
}

# -----------------------------------------
# EC2 Instance in Private Subnet
# -----------------------------------------
resource "aws_instance" "private_instance" {
  ami           = "ami-0fa3fe0fa7920f68e"   # <-- replace this with your AMI ID
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  associate_public_ip_address = false  # no public IP

  tags = {
    Name = "private-ec2"
  }
}