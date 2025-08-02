output "vpc_id" {
  value = aws_vpc.my_custom_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet_A.id
}