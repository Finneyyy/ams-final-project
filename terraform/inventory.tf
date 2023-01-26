data "template_file" "inventory" {
  template = file("./templates/inventory.tpl")
  vars = {
    "web-server" = aws_instance.web-server[0].public_ip
  }
}

resource "local_file" "inventory_file" {
  content = data.template_file.inventory.rendered
  filename = "inventory.yaml"
} 