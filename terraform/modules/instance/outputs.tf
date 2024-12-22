output "bastion_host_id" {
  value = aws_instance.bastion_host.id
}

output "mysql_instance_id" {
  value = aws_instance.mysql_instance.id
}

