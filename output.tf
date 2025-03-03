output "instance_name" {
    description = "name of the instance"    
    value = var.instance_name
}

output "instance_id" {
    description = "id of the instance"  
    value = aws_instance.wordpress_host.id  
}

output "public_ip_of_host" {
  description = "this is the public ip adress of host"
  value = aws_instance.wordpress_host.public_ip
}