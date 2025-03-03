resource "aws_instance"  "wordpress_host" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name = var.instance_key
  subnet_id           = aws_subnet.wordpress_subnet.id
  vpc_security_group_ids = [aws_security_group.wordpress_sg.id]

  
  user_data                    = file("${path.module}/app.sh")
  tags = {
    Name = "wordpress_host"
    instance_name = "wordpress_host"
  }
  
}