resource "aws_nat_gateway" "gw1a" {
  # The Allocation ID of the Elastic IP address for the gateway.
  allocation_id = aws_eip.nat1a.id

  # The Subnet ID of the subnet in which to place the gateway.
  subnet_id = aws_subnet.production-subnet.id

  # A map of tags to assign to the resource.
  tags = {
    Name = "NAT 1a"
  }
}

resource "aws_nat_gateway" "gw1b" {
  # The Allocation ID of the Elastic IP address for the gateway.
  allocation_id = aws_eip.nat1b.id

  # The Subnet ID of the subnet in which to place the gateway.
  subnet_id = aws_subnet.production-subnet.id

  # A map of tags to assign to the resource.
  tags = {
    Name = "NAT 1b"
  }
}