terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
  }
}

variable "ubuntu_ami_id" {
    default ="ami-0f918f7e67a3323f0" 
}
resource "aws_instance" "ubuntu_instances" {
    ami = var.ubuntu_ami_id
    instance_type = "t2.micro"
    associate_public_ip_address = true

    tags = {
      Name = "EC2-testing-test"
    }
}
output "public_ips" {
  value = aws_instance.ubuntu_instances.public_ip
}