variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "database_vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_web_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_database_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "master_vpc_id" {
  description = "Master VPC ID for peering"
  type        = string
  default     = "vpc-0feb480adeeba0347"
}

variable "master_route_table_id" {
  description = "Master VPC Route Table ID"
  type        = string
  default     = "rtb-04dd6c158fec5d70c"
}

variable "ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-005fc0f236362e99f"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "key_name"
  type        = string
  default     = "jenkins"
}

variable "master_vpc_cidr" {
  description = "CIDR block for the master VPC"
  type        = string
  default     = "172.31.0.0/16"
}
