variable "region" {
    description = "Enter region"
    default = "us-east-1"
    type = string
  
}

variable "instance_type" {
    description = "Enter instance type"
    default = "t3.micro"
    type = string
  
}

variable "ports" {
    description = "Enter list of ports to open"
    type = list
    default = ["80", "443"]
  
}

variable "monitor" {
    default = "false"
    type = bool
}