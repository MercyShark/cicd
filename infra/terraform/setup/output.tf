output "backend_server_public_ip" {
  value = module.backend_server.backend_server_public_ip
}


output "rds_endpoint" {
  value = module.database-server.rds_endpoint
}

output "rds_port" {
  value = module.database-server.rds_port
}