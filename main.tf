provider "aws" {}

locals {
  full_name           = "${var.instance_name}-${var.project}"
  proj_owner          = "${var.owner} from ${var.location}"
  instance_parametres = "ami = ${var.ami}, instance type = ${var.instance_type}, location = ${var.location}"



}


resource "aws_instance" "my_server" {
  ami           = var.ami
  instance_type = var.instance_type


  tags = {
    Name       = var.instance_name
    Owner      = local.proj_owner
    Project    = local.full_name
    Location   = var.location
    Parameters = local.instance_parametres
  }

}
