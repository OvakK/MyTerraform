variable "instance_type" {
  default     = "t3.micro"
  type        = string

}

variable "ami" {
  default = "ami-0b5eea76982371e91"
}

variable "instance_name" {
  type        = string
  description = "Enter name of instance"
}

variable "location" {
  type    = string
  default = "Gyumri"
}


variable "project" {
  default = "Terraformation"
}

variable "owner" {
  default = "Ovak"

}
