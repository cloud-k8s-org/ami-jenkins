packer {
  required_version = ">= 1.5.0"
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

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

variable "jenkins_username" {
  type = string
}

variable "jenkins_password" {
  type = string
}

source "amazon-ebs" "jenkins-ami" {
  ami_name      = "${var.ami_name}-{{timestamp}}"
  instance_type = var.instance_type
  region        = var.aws_region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  ssh_username = var.ssh_username
  ami_users    = [var.ami_user]
  profile      = var.profile
}

build {
  sources = ["source.amazon-ebs.jenkins-ami"]

  provisioner "file" {
    source      = "install_script.sh"
    destination = "/tmp/install_script.sh"
  }

  provisioner "file" {
    source      = "create_jenkins_user.sh"
    destination = "/tmp/create_jenkins_user.sh"
  }

  provisioner "file" {
    source      = "InitJenkins.groovy"
    destination = "/tmp/InitJenkins.groovy"
  }

  provisioner "file" {
    source      = "JenkinsPlugins.txt"
    destination = "/tmp/JenkinsPlugins.txt"
  }

  provisioner "file" {
    source      = "install_plugins.sh"
    destination = "/tmp/install_plugins.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install_script.sh",
      "/tmp/install_script.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "JENKINS_USERNAME=${var.jenkins_username}",
      "JENKINS_PASSWORD=${var.jenkins_password}"
    ]
    inline = [
      "chmod +x /tmp/create_jenkins_user.sh",
      "/tmp/create_jenkins_user.sh"
    ]
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install_plugins.sh",
      "/tmp/install_plugins.sh"
    ]
  }
}