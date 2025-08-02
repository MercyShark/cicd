output "vpc_id" {
  value = aws_vpc.my_custom_vpc.id
}

output "public_subnet_id_A" {
  value = aws_subnet.public_subnet_A.id
}

output "public_subnet_id_B" {
  value = aws_subnet.public_subnet_B.id
}



