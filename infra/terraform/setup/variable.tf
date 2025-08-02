variable "vpc_cidr_block_address" {
}
variable "public_subnet_a_cidr_block" {
}

variable "public_subnet_b_cidr_block" {
}

variable "region" {  
}
variable "availability_zone_a" {
}

variable "availability_zone_b" {
}
variable "public_key_path" {
}
variable "ubuntu_ami_id" {
}
variable "instance_type" {    
}


variable "identifier" {
  description = "unique name"
}
variable "engine" {
    description = "which type of database you want to create e.g postgre, mariadb, sql server, mysql"
}
variable "engine_version" {
    description = "which database version you want"
}
variable "instance_class" {
    description = "which backend instance you want on which the db will work on"
}

variable "storage_type" {
    description = "which type of drive or disk you want e.g gp2, gp3.."
}

variable "storage_amount" {
  
}
variable "db_name" {
    description = "init database name"
}

variable "username" {
    description = "username of db"
}

variable "password" {
    description = "password for db"
}

variable "publicly_accessible" {
    description = "it will make ur db public by.. giving an public ip address (imp)"
}

variable "backup_rentention_period" {
    description = "it tells you for how many days you want to keep the backup e.g 7 days"
}

variable "backup_window" {
    description = "daily backup time in (UTC) e.g 03.00-04:00"
}

variable "auto_minor_version_upgrade" {
    description = "auto patching.. security patches and fixes"
}

variable "deletion_protection" {
  description = "Allow deletion .. by default you can't deletet. you have to set termination to false then an only"
}

variable "skip_final_snapshot" {
  description = "wheater to create an final snapshot of the db or not on Destroy"
}
