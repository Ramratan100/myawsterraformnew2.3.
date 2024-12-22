output "bastion_host_public_ip" {
  description = "The public IP address of the bastion host."
  value       = module.my_module.bastion_host_public_ip
}

output "mysql_instance_private_ip" {
  description = "The private IP address of the MySQL instance."
  value       = module.my_module.mysql_instance_private_ip
}
