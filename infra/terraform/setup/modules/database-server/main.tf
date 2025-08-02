provider "aws" {
  region = var.region
}

# get the public ip
data "external" "ip_lookup" {
  program = ["python", "${path.module}/get_public_ip.py"]
}

# security group 
resource "aws_security_group" "database_access_sg_group" {
  name   = "my_custom_db_sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    description = "For Postgres RDS"
    protocol    = "tcp"
    cidr_blocks = [
      data.external.ip_lookup.result["authorized_ip"]
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
    Name : "Custom Security Group Build using Terraform for RDS"
  }
}


resource "aws_db_subnet_group" "my_custom_db_subnet_group" {
  name       = "my_custom_db_subnet_group"
  subnet_ids = var.public_subnet_ids
  
  tags = {
    Name = "My Custom DB Subnet Group"
  }
  
}

resource "aws_db_instance" "my_postgres_db" {
    identifier = var.identifier
    instance_class = var.instance_class
    engine = var.engine
    engine_version = var.engine_version
    storage_type = var.storage_type
    allocated_storage = var.storage_amount

    db_name = var.db_name
    username = var.username
    password = var.password

    publicly_accessible = var.publicly_accessible
    vpc_security_group_ids = [
    aws_security_group.database_access_sg_group.id
    ]
    db_subnet_group_name = aws_db_subnet_group.my_custom_db_subnet_group.name

    backup_retention_period = var.backup_rentention_period
    backup_window = var.backup_window

    auto_minor_version_upgrade = var.auto_minor_version_upgrade
    deletion_protection = var.deletion_protection
    skip_final_snapshot = var.skip_final_snapshot

    multi_az = false
    
    tags = {
        Project  = "building rds with terraform"
    }
}   