provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "my_webserver" {
    ami = "ami-0b5eea76982371e91"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_security.id]
  
    tags = {
      Name = "Server-Web"
    }
    depends_on = [aws_instance.my_appserver]

}

resource "aws_instance" "my_appserver" {
    ami = "ami-0b5eea76982371e91"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_security.id]
  
    tags = {
      Name = "Server-Application"
    }
    depends_on = [aws_instance.my_dbserver]
}

resource "aws_instance" "my_dbserver" {
    ami = "ami-0b5eea76982371e91"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.my_security.id]
  
    tags = {
      Name = "Server-Database"
    }
}


resource "aws_security_group" "my_security" {
    name = "My Security Group"

    dynamic "ingress" {
        for_each = ["80", "443"]
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "My SecurityGroup" 
    }    
}