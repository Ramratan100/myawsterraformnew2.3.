output "bastion_host_id" {
  value = aws_instance.bastion_host.id
}
 
output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}
 
output "mysql_instance_id" {
  value = aws_instance.mysql_instance.id
}
 
output "mysql_instance_private_ip" {
  value = aws_instance.mysql_instance.private_ip
}


