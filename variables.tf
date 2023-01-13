variable "instance_type" {
  description = "Enter instance type"
  default     = "t3.micro"
  type        = string

}

variable "ami" {
  default = "ami-0b5eea76982371e91"
}

variable "instance_name" {
  default     = "MyServer"
  type        = string
  description = "Enter name of instance"
}

variable "location" {
    type = string
    default = "Oregon"
}