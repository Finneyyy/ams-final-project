# production subnet - public
resource "aws_subnet" "production-subnet" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    "Name" = "Production-Subnet"
  }
}

# DB subnet AV 1a
resource "aws_subnet" "db-subnet-1a" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    "Name" = "DB-Subnet-1a"
  }
}

# DB subnet AV 1b
resource "aws_subnet" "db-subnet-1b" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    "Name" = "DB-Subnet-1b"
  }
}
