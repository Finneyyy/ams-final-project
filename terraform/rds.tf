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
  vpc_security_group_ids = [aws_security_group.allow_db_connect.id]

  tags = {
    "Name" = "back_end-db"
  }
}