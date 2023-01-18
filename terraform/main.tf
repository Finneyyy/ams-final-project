terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"] # TO BE CHANGED
  region                   = "eu-west-1"
}

# vpc
resource "aws_vpc" "production-vpc" { # resouce terraform-name
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Production-VPC" # aws name
  }
}

# internet gateway
resource "aws_internet_gateway" "production-igw" {
  vpc_id = aws_vpc.production-vpc.id # resouce.terraform-name

  tags = {
    Name = "Production-IGW"
  }
}

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

# subnet
resource "aws_subnet" "production-subnet" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    "Name" = "Production-Subnet"
  }
}

# assign subnet with route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.production-subnet.id
  route_table_id = aws_route_table.production-route-table.id
}

# security group
resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web in traffic"
  vpc_id      = aws_vpc.production-vpc.id

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # any protocol
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

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

# assign public IP
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.produciton-subnet-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.production-igw]
}

# EC2 instance 
resource "aws_instance" "web-server" {
  ami               = "ami-026e72e4e468afa7b"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1a"
  key_name          = "jen-irl" # TO BE CHANGED

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
#####################################################################################################

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

# DB subnet AV 1a
resource "aws_subnet" "db-subnet-1a" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    "Name" = "DB-Subnet-1a"
  }
}

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

resource "aws_eip" "nat1a" {
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.production-igw]
}

# assign subnet with route table
resource "aws_route_table_association" "db-1" {
  subnet_id      = aws_subnet.db-subnet-1a.id
  route_table_id = aws_route_table.db-route-table-1a.id
}

########################################################
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

# DB subnet AV 1b
resource "aws_subnet" "db-subnet-1b" {
  vpc_id            = aws_vpc.production-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    "Name" = "DB-Subnet-1b"
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

resource "aws_eip" "nat1b" {
  # EIP may require IGW to exist prior to association. 
  # Use depends_on to set an explicit dependency on the IGW.
  depends_on = [aws_internet_gateway.production-igw]
}

# assign subnet with route table
resource "aws_route_table_association" "db-1b" {
  subnet_id      = aws_subnet.db-subnet-1b.id
  route_table_id = aws_route_table.db-route-table-1b.id
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.db-subnet-1a.id, aws_subnet.db-subnet-1b.id]

  tags = {
    Name = "DB subnet group"
  }
}

# RDS instance
resource "aws_db_instance" "default" {
  allocated_storage     = 10
  max_allocated_storage = 50
  db_name               = "petclinic"
  engine                = "mysql"
  engine_version        = "5.7.40"
  instance_class        = "db.t2.micro"
  username              = "pc"
  password              = "petclinic"
  parameter_group_name  = "default.mysql5.7"
  skip_final_snapshot   = true
  availability_zone     = "eu-west-1a"
  db_subnet_group_name  = "main"
  # vpc_security_group_ids = 

  tags = {
    "Name" = "back_end-db"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}
resource "local_file" "public_inventory" {
  filename = "./inventory/publicIPs.ini"
  content  = "output.rds_endpoint"
}