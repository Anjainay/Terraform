terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.45.0"
    }
  }
}
provider "aws" {

   profile = "default"
   region  = "us-east-1"
   
}
variable "aws_region" {
  description = "Region in which we will install EC2 intances"
  type        = string 
  default     = "us-east-1"
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0bb84b8ffd87024d8"
}

variable "ec2_instance_count" {
 description = "EC2 instance count"
 type        = number
 default     = 1
}

resource "aws_instance" "danger" {
ami           = var.ec2_ami_id
instance_type = "t2.micro"
key_name      = "Ananya"
count         = var.ec2_instance_count                          
user_data     = <<-EOF
   sudo yum update -y
   sudo yum install httpd -y
   sudo systemctl enable httpd
   sudo systemctl start httpd
   echo "<h1>Hello ! We are laerning Terraform</h1>" > /var/www/html/index.html
   EOF
 tags = {
  "Name" = "myec2vm"
}
}
