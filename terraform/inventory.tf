resource "local_file" "inventory_file" {
  filename = "./host.ini"
  content = <<EOF
  [web-server]
  ${aws_instance.web-server.public_ip}
  EOF
} 