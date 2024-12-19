resource "aws_instance" "bastion_host" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.public_vpc_security_group_ids
  associate_public_ip_address = true

  tags = {
    Name = "Bastion-Host"
  }
}

resource "aws_instance" "mysql_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
   key_name              = "jenkins"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.mysql_sg_id]

  tags = {
    Name = "MySQL-Instance"
  }
}
