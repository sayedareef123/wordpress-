resource "aws_route_table" "wordpress_route_table" {
  vpc_id = aws_vpc.wordpress-vpc.id

  route {
    cidr_block = "0.0.0.0/0" # Default route for all outbound traffic
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "wordpress-route-table"
  }
}

resource "aws_route_table_association" "wordpress_route_table_association" {
  subnet_id      = aws_subnet.wordpress_subnet.id
  route_table_id = aws_route_table.wordpress_route_table.id
}