packer {
  required_version = ">= 1.5.0"
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
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

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install_script.sh",
      "/tmp/install_script.sh"
    ]
  }
}