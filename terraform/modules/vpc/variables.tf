variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

ariable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  tyvpe        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "master_vpc_id" {
  description = "Master VPC ID for peering"
  tyvpe        = string
}

variable " master_route_table_id" {
  description = "Master VPC Route Table ID"
  type        = string
}
