# assign public IP
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.produciton-subnet-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.production-igw]
}

resource "aws_eip" "nat1a" {
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.production-igw]
}

resource "aws_eip" "nat1b" {
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.production-igw]
}