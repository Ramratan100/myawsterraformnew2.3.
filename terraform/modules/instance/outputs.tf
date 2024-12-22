output "bastion_instance_id" {
  value = aws_instance.bastion_instance.id
}

output "mysql_instance_id" {
  value = aws_instance.mysql_instance.id
}
