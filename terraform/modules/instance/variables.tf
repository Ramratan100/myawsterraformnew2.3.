variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}

variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
}

variable "bastion_sg_id" {
  description = "Bastion Security Group ID"
  type        = string
}

variable "mysql_sg_id" {
  description = "MySQL Security Group ID"
  type        = string
}

variable "key_name" {
  description = "key_name"
  type        = string
}

variable "public_subnet_id" {
  description = public_subnet_id
  type        = string
}

variable "public_vpc_security_group_ids" {
  description = public_vpc_security_group_ids
  type        = string
}