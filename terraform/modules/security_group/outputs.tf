output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "mysql_sg_id" {
  value = aws_security_group.mysql_sg.id
}