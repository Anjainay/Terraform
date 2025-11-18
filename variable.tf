variable "aws_region" {
 description = "region in which AWS resource need to be created" 
 type = string
 default = "us-east-1"
}
variable "ec2_ami_id" {
description = "AMI_ID"
type = string
default ="ami-0cae6d6fe6048ca2c"
}
variable "ec2_instance_count" {
  description = "number of instances"
  type = number
  default = 2
}