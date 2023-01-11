provider "aws" {
  region = var.region
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_server.id
  tags = {
    Name    = "Server IP"
    Owner   = "Ovak Kurginyan"
    Project = "KOK"
  }

}


resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server.id]
  monitoring = var.monitor


  tags = {
    Name    = "Web Server Build by Terraform"
    Owner   = "Ovak Kurginyan"
    Project = "KOK"
  }

}

resource "aws_security_group" "my_server" {
  name = "My Security Group"

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

egress  {
  cidr_blocks = [ "0.0.0.0/0" ]
  from_port = 0
  protocol = "-1"
  to_port = 0
} 


    tags = {
      Name    = "Web Server SecurityGroup"
      Owner   = "Ovak Kurginyan"
      Project = "KOK"
    }
  }

