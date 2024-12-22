output "bastion_host_id" {
  description = "The ID of the bastion host instance."
  value       = aws_instance.bastion_host.id
}

output "mysql_instance_id" {
  description = "The ID of the MySQL instance."
  value       = aws_instance.mysql_instance.id
}
