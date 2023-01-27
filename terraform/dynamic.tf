resource "local_file" "dynamic_inventory" {
  content  = "[webservers]\n ${aws_instance.web-server.public_ip}\n"
  filename = "../inventory.yaml"
} 