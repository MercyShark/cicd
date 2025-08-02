output "rds_endpoint" {
  value = aws_db_instance.my_postgres_db.endpoint
}

output "rds_port" {
  value = aws_db_instance.my_postgres_db.port
}