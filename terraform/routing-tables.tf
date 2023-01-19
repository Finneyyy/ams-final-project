# production route table
resource "aws_route_table" "production-route-table" {
  vpc_id = aws_vpc.production-vpc.id

  route {
    cidr_block = "0.0.0.0/0" # all ipv4 trafic to our internet gateway
    gateway_id = aws_internet_gateway.production-igw.id
  }

  route {
    ipv6_cidr_block = "::/0" # all ipv6 to our internet gateway
    gateway_id      = aws_internet_gateway.production-igw.id
  }

  tags = {
    Name = "Production-RT"
  }
}

# DB route table 1a
resource "aws_route_table" "db-route-table-1a" {
  vpc_id = aws_vpc.production-vpc.id

  route {
    cidr_block     = "0.0.0.0/0" # all ipv4 trafic to our internet gateway
    nat_gateway_id = aws_nat_gateway.gw1a.id
  }

  # route {
  #   ipv6_cidr_block = "::/0" # all ipv6 to our internet gateway
  #   egress_only_gateway_id  = aws_nat_gateway.gw1a.id
  # }

  tags = {
    Name = "DB-RT-1a"
  }
}

# DB route table 1b
resource "aws_route_table" "db-route-table-1b" {
  # The VPC ID.
  vpc_id = aws_vpc.production-vpc.id

  route {
    # The CIDR block of the route.
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC NAT gateway.
    nat_gateway_id = aws_nat_gateway.gw1b.id
  }

  # route {
  #   ipv6_cidr_block = "::/0" # all ipv6 to our internet gateway
  #   nat_gateway_id  = aws_nat_gateway.gw1b.id
  # }

  # A map of tags to assign to the resource.
  tags = {
    Name = "DB-RT-1b"
  }
}