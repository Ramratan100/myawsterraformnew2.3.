resource "aws_instance" "bastion_host" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  security_groups = [var.bastion_sg_id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion-Host"
  }
}

resource "aws_instance" "mysql_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.private_subnet_id
  security_groups = [var.mysql_sg_id]



  tags = {
    Name = "MySQL-Instance"
  }
}
