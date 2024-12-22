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

output "bastion_intance_ip" {
  value = module.instance.bastion_intance_ip
}

output "mysql_instance_ip" {
  value = module.instance.mysql_instance_ip
}
