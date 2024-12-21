output "database_vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.database_vpc_id
}

output "public_subnet_web_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_web_id
}

output "private_subnet_database_id" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_database_id
}

output "bastion_instance_id" {
  description = "The ID of the Bastion host instance"
  value       = module.instance.bastion_instance_id
}

output "mysql_instance_id" {
  description = "The ID of the MySQL instance"
  value       = module.instance.mysql_instance_id
}

output "bastion_instance_id" {
  value = aws_instance.bastion_host.id
}

output "mysql_instance_id" {
  value = aws_instance.mysql_instance.id
}

output "bastion_host_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = aws_instance.bastion_instance.public_ip
}

output "mysql_instance_private_ip" {
  description = "Private IP of the MySQL Instance"
  value       = aws_instance.mysql_instance.private_ip
}

