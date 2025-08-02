provider "aws" {
  region = var.region
}

module "vpc_subnet" {
  source = "./modules/vpc_subnet"
  availability_zone_a = var.availability_zone_a
  availability_zone_b = var.availability_zone_b
  public_subnet_a_cidr_block = var.public_subnet_a_cidr_block
  public_subnet_b_cidr_block = var.public_subnet_b_cidr_block
  vpc_cidr_block_address = var.vpc_cidr_block_address
  region = var.region
}

module "backend_server" {
  source = "./modules/backend_server"
  instance_type = var.instance_type
  public_key_path = var.public_key_path
  subnet_id = module.vpc_subnet.public_subnet_id_A
  vpc_id = module.vpc_subnet.vpc_id
  ubuntu_ami_id = var.ubuntu_ami_id
  region = var.region
}


module "database-server" {
  source = "./modules/database-server"
  identifier = var.identifier
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  storage_type = var.storage_type
  storage_amount = var.storage_amount
  db_name = var.db_name
  username = var.username
  password = var.password
  publicly_accessible = var.publicly_accessible
  backup_rentention_period = var.backup_rentention_period
  backup_window = var.backup_window
  vpc_id = module.vpc_subnet.vpc_id
  region = var.region
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection
  public_subnet_ids = [
    module.vpc_subnet.public_subnet_id_A,
    module.vpc_subnet.public_subnet_id_B
  ]
}