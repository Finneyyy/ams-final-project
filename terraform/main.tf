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

# route table
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

# # DB subnet
# resource "aws_subnet" "db-subnet" {
#   vpc_id            = aws_vpc.production-vpc.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "eu-west-1a"

#   tags = {
#     "Name" = "DB-Subnet"
#   }
# }

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.db-subnet.id]

  tags = {
    Name = "DB subnet group"
  }
}

# RDS instance
resource "aws_db_instance" "default" {
  allocated_storage     = 10
  max_allocated_storage = 50
  db_name               = "mydb"
  engine                = "mysql"
  engine_version        = "5.7.40"
  instance_class        = "db.t2.micro"
  username              = "test"
  password              = "test"
  parameter_group_name  = "default.mysql5.7"
  skip_final_snapshot   = true
  availability_zone     = "eu-west-1a"
  # db_subnet_group_name = 
  # vpc_security_group_ids = 
  
  tags = {
    "Name" = "back_end-db"
  }
}