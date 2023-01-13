variable "region" {
  description = "Enter region"
  default     = "us-east-1"
  type        = string

}

variable "instance_type" {
  description = "Enter instance type"
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
