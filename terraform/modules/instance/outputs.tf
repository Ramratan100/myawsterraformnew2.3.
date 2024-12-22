output "bastion_host_public_ip" {
  description = "The public IP address of the bastion host instance."
  value       = aws_instance.bastion_host.public_ip
}

output "mysql_instance_private_ip" {
  description = "The private IP address of the MySQL instance."
  value       = aws_instance.mysql_instance.private_ip
}
