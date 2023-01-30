output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "ec2_instance_ip" {
  value = aws_instance.web-server.public_ip
}

output "ec2_instance_dns" {
  value = aws_instance.web-server.public_dns
}

