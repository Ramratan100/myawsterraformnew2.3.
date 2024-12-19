variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr" {
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

variable "public_subnet_id" {
  description = public_subnet_id
  type        = string
  default     = aws_subnet.public_subnet_web.id
}

variable "public_vpc_security_group_ids" {
  description = public_vpc_security_group_ids
  type        = string
  default     = [aws_security_group.bastion_sg.id]
}
