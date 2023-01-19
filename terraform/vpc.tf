# vpc
resource "aws_vpc" "production-vpc" { # resouce terraform-name
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Production-VPC" # aws name
  }
}