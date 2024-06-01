variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "ami_name" {
  type    = string
  default = "jenkins-ami"
}

variable "profile" {
  type = string
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "ami_user" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}