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
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "gw"
  }
}
resource "aws_subnet" "cisco" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "cisco"
  }
}
resource "aws_subnet" "infosys" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "infosys"
  }
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
resource "aws_instance" "web" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  subnet_id = "aws_subnet_infosys.id"
  key_name = "Ananya"
  tags = {
    Name = "web"
  }
}
resource "aws_instance" "server" {
  ami           ="ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  subnet_id = "aws_subnet_cisco.id"
   key_name      =  "Ananya"

  tags = {
    Name = "server"
  }
}

resource "aws_network_interface" "test"{
  subnet_id       = "${aws_subnet.cisco.id}"
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.allow_tls.id]

  attachment {
    instance     = "${aws_instance.web.id}"
    device_index = 1
  }
}
resource "aws_network_interface" "laptop" {
  subnet_id       = "${aws_subnet.infosys.id}"
  private_ips     = ["10.0.0.60"]
  security_groups = [aws_security_group.allow_tls.id]

  attachment {
    instance     = "${aws_instance.server.id}"
    device_index = 1
  }
}

