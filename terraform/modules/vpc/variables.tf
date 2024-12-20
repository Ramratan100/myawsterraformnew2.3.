variable "database_vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_web_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_database_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "master_vpc_id" {
  description = "Master VPC ID for peering"
  type        = string
}

variable "master_route_table_id" {
  description = "Master VPC Route Table ID"
  type        = string
}

variable "master_vpc_cidr" {
  description = "CIDR block for the master VPC"
  type        = string
}
