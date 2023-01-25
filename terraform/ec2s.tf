# EC2 instance 
resource "aws_instance" "web-server" {
  ami               = "ami-026e72e4e468afa7b"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1a"
  key_name          = "MasterKeys" # TO BE CHANGED

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.produciton-subnet-nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              echo here we go
              EOF

  tags = {
    "Name" = "web-server"
  }
}