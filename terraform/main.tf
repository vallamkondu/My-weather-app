provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t3.micro"

  tags = {
    Name = "Custom-AMI-EC2"
  }
}
