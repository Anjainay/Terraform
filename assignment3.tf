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

provider "aws" {
   region  = "us-east-2"
   alias   = "usa"
}
resource "aws_instance" "hello-virgina"{
  ami           =  "ami-051f8a213df8bc089"
  instance_type =  "t2.micro"
  key_name      =  "Ananya"
  subnet_id     =  "subnet-0038282a69edd8882"
 tags ={
"Name" = "hello-virginia"
}
}
resource "aws_instance" "Hello-Ohio"{
  ami           =  "ami-0b8b44ec9a8f90422"
  instance_type =  "t2.micro"
  provider      =  aws.usa
  tags ={
"Name" = "Hello-Ohio"
} 
}

