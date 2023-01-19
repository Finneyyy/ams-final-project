resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.db-subnet-1a.id, aws_subnet.db-subnet-1b.id]

  tags = {
    Name = "DB subnet group"
  }
}