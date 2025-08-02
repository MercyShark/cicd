provider "aws" {
  region = var.region
}

module "vpc_subnet" {
  source = "./modules/vpc_subnet"
  availability_zone = var.availability_zone
  public_subnet_a_cidr_block = var.public_subnet_a_cidr_block
  vpc_cidr_block_address = var.vpc_cidr_block_address
  region = var.region
}

module "backend_server" {
  source = "./modules/backend_server"
  instance_type = var.instance_type
  public_key_path = var.public_key_path
  subnet_id = module.vpc_subnet.public_subnet_id
  vpc_id = module.vpc_subnet.vpc_id
  ubuntu_ami_id = var.ubuntu_ami_id
  region = var.region
}
