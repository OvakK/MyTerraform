provider "aws" {
  region = "us-east-1"
}

terraform {
  backend = "backet_name"
  key     = "dev/servers/terraform.tfstate"
  region  = "us-east-1"
}



resource "aws_vpc" "my_vpc" {

  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "test_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "main"
  }
}


resource "aws_instance" "my_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_security.id]
  subnet_id              = aws_subnet.my_subnet.id
  depends_on             = [aws_internet_gateway.gw]

  tags = {
    Name = var.instance_name

  }
}


resource "aws_security_group" "my_security" {
  name        = "my_security"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.my_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "my_secure"
  }
}
