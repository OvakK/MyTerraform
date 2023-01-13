provider "aws" {
  region = var.region
}


resource "aws_instance" "my_server" {
  ami                    = var.ami
  instance_type          = var.instance_type


  tags = {
    Name    = var.instance_name
    Owner   = "Ovak Kurginyan"
    Project = "KOK"
  }

}
