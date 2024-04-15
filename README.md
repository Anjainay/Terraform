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

resource "aws_instance" "venom"{
  ami           =  "ami-0b8b44ec9a8f90422"
  instance_type =  "t2.micro"
}
