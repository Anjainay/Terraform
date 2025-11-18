terraform {
  required_version = ">= 1.4"
  
  # FIX: Changed "S3" to "s3" (backends are typically lowercase)
  backend "s3" { 
    bucket = "anjainaybackendcode123"
    key    = "code/terraform.tfstate"
    region = "us-east-1"
  }
    
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

}

provider "aws" {
  region  = "us-east-1" 
  profile = "default"
}