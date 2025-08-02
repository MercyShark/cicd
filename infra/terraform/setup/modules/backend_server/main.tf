provider "aws" {
  region = var.region
}

# ssh keys
resource "aws_key_pair" "testing_key_pair" {
  key_name   = "my test key"
  public_key = file(var.public_key_path)
}

# get the public ip
data "external" "ip_lookup" {
  program = ["python", "${path.module}/get_public_ip.py"]
}

# security group 
resource "aws_security_group" "my_custom_sg_for_public_instance" {
  name   = "my_custom_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    description = "For Accessing the public Instance"
    protocol    = "tcp"
    cidr_blocks = [
      data.external.ip_lookup.result["authorized_ip"]
    ]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    description = "For Web Server Nginx"
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name : "Custom Security Group Build using Terraform"
  }
}



resource "aws_instance" "sample_ec2_instance" {
  ami                         = var.ubuntu_ami_id
  subnet_id                   = var.subnet_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.testing_key_pair.key_name
  vpc_security_group_ids  = [
    aws_security_group.my_custom_sg_for_public_instance.id
  ]
  tags = {
    Name : "Bastion Host"
  }
}
