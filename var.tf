
variable "cidr_block" {
  description = "cidr block for the host server"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
    description = "name of the vpc"
    type = string 
    default = "wordpress-host-vpc"      
}

variable "aws_region" {
    description = "region for aws infra"
    type = string
}

variable "availability_zone" {
  description = "availability zone for instance"
  type = string
}


variable "instance_ami" {
  description = "this is the ami of the instance"
  type = string
}

variable "instance_name" {
  description = "this is the name of the instance"
  type = string
}   

variable "instance_key" {
  description = "the key for instance"
  type = string
}

variable "instance_type" {
 description = "this is the type of the instance"
 type = string 
}