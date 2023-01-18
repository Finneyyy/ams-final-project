# internet gateway
resource "aws_internet_gateway" "production-igw" {
  vpc_id = aws_vpc.production-vpc.id # resouce.terraform-name

  tags = {
    Name = "Production-IGW"
  }
}