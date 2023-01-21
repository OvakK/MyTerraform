provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "mytfstatesbucket"
    key     = "dev/network/terraform.tfstate"
    region  = "us-east-1"
  }

}




resource "aws_vpc" "my_vpc" {

  cidr_block       = "172.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.0.10.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "test_subnet"
  }
}



resource "aws_instance" "my_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_security.id]
  subnet_id              = aws_subnet.my_subnet.id

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
  }

  tags = {
    Name = "my_secure"
  }
}
