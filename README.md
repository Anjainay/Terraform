# Terraform
Terraform codes
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
   region  = "us-east-2"
}
#Resource block 
#Resource block 

resource "aws_instance" "web"{
  ami           =  "ami-051f8a213df8bc089"
  instance_type =  "t2.micro"
  key_name      =  "Ananya"
  subnet_id     =  "subnet-0038282a69edd8882"
}
 resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  domain   = "vpc"

}
  
