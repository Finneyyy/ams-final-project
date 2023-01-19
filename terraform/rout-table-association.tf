# assign subnet with route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.production-subnet.id
  route_table_id = aws_route_table.production-route-table.id
}

# assign subnet with route table
resource "aws_route_table_association" "db-1" {
  subnet_id      = aws_subnet.db-subnet-1a.id
  route_table_id = aws_route_table.db-route-table-1a.id
}

# assign subnet with route table
resource "aws_route_table_association" "db-1b" {
  subnet_id      = aws_subnet.db-subnet-1b.id
  route_table_id = aws_route_table.db-route-table-1b.id
}