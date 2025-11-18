resource "aws_instance" "example" {
  ami           = "ami-0cae6d6fe6048ca2c"  # Amazon Linux 2 AMI in us-east-1; update as needed
  instance_type = "t3.micro"

  tags = {
    Name = "ExampleInstance"
  }
}