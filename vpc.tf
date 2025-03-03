resource "aws_vpc" "wordpress-vpc" {
  cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = var.vpc_name
    } 
}