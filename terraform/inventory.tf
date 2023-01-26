resource "local_file" "inventory_file" {
  filename = "inventory.yaml"
  content = <<EOF
  [web-server]
  ${aws_instance.web-server.public_ip}
  EOF
} 