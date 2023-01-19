# network interface
resource "aws_network_interface" "produciton-subnet-nic" {
  subnet_id       = aws_subnet.production-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]

  #   attachment {
  #     instance     = aws_instance.test.id
  #     device_index = 1
  #   }
}