output "database_vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.database_vpc.id
}

output "public_subnet_web_id" {
  description = "The ID of the public web subnet"
  value       = aws_subnet.public_subnet_web.id
}

output "private_subnet_database_id" {
  description = "The ID of the private database subnet"
  value       = aws_subnet.private_subnet_database.id
}
