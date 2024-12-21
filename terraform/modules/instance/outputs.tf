output "bastion_instance_id" {
  value = aws_instance.bastion_host.id
}

output "mysql_instance_id" {
  value = aws_instance.mysql_instance.id
}

output "bastion_host_public_ip" {
  value = aws_instance.bastion_instance.public_ip
}

output "mysql_instance_private_ip" {
  value = aws_instance.mysql_instance.private_ip
}
