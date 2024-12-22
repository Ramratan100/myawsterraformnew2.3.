provider "aws" {
  region = var.region
}

# Add the relevant module calls
module "vpc" {
  source = "./modules/vpc"
  database_vpc_cidr            = var.database_vpc_cidr
  public_subnet_web_cidr       = var.public_subnet_web_cidr
  private_subnet_database_cidr = var.private_subnet_database_cidr
  master_vpc_id                = var.master_vpc_id
  master_route_table_id        = var.master_route_table_id
  master_vpc_cidr              = var.master_vpc_cidr
}

module "security_group" {
  source            = "./modules/security_group"
  database_vpc_id            = module.vpc.database_vpc_id
  public_subnet_web_cidr     = var.public_subnet_web_cidr
}

module "instance" {
  source           = "./modules/instance"
  ami              = var.ami
  instance_type    = var.instance_type
  key_name         = var.key_name
  bastion_sg_id    = [module.security_group.bastion_sg_id]
  mysql_sg_id      = [module.security_group.mysql_sg_id]
  private_subnet_id = [module.vpc.private_subnet_database_id]
  public_subnet_id  = [module.vpc.public_subnet_web_id]
}
