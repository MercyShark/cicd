terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "region" {}
variable "bucket_name" {}
variable "lock_table_name" {}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "tf_state" {
    bucket = var.bucket_name
    tags = {
        Name: "Bucket for Storing Terraform state files"
    }
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_dynamodb_table" "tf_lock_db" {
  name = var.lock_table_name
  billing_mode = "PROVISIONED"
  read_capacity = 1
  write_capacity = 1
  hash_key = "LockID" # defining primary key

  attribute {
    name = "LockID" # defining primary key data type
    type = "S" 
  }
  tags = {
    Name = "Terraformm Lock Table"
  }
}