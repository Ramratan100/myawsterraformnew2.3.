provider "aws" {
  region = var.region
}

# Add the relevant module calls
module "vpc" {
  source = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security_group" {
  source            = "./modules/security_group"
  vpc_id            = module.vpc.vpc_id
  public_subnet_cidr = var.public_subnet_cidr
}

module "instance" {
  source            = "./modules/instance"
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = var.key_name
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  bastion_sg_id     = module.security_group.bastion_sg_id
  mysql_sg_id       = module.security_group.mysql_sg_id
  public_vpc_security_group_ids = [module.security_group.bastion_sg.id]
  private_vpc_security_group_ids = [module.security_group.mysql_sg.id]
}