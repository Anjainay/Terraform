resource "aws_instance" "example" {
  ami           = var.ec2_ami_id  # Amazon Linux 2 AMI in us-east-1; update as needed
  instance_type = "t3.micro"
    count       = var.ec2_instance_count
 tags = {
    Name = "ExampleInstance"
  }
}