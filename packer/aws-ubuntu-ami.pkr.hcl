packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}


source "amazon-ebs" "ubuntu" {
  region        = "${var.region}"
  ami_name      = "${var.ami_name}"
  instance_type = "${var.instance_type}"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"] # Canonical Ubuntu official AMI owner ID
    most_recent = true
  }
  ssh_username = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "file" {
    source      = "install_tools.sh"
    destination = "/tmp/install_tools.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/install_tools.sh",
      "/tmp/install_tools.sh '${var.docker_version}' '${var.buildah_version}' '${var.kubectl_version}' '${var.helm_version}'"
    ]
  }
}
