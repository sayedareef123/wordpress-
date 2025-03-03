resource "aws_subnet" "wordpress_subnet" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = var.cidr_block 
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true   

  tags = {
    Name = "wordpress-subnet"
  }
}