# Route table associations for both Public & Private Subnets
resource "aws_route_table_association" "public-route-association-sub1" {
  route_table_id = aws_route_table.Public-route.id
  subnet_id      = aws_subnet.public-subnet1.id
}
resource "aws_route_table_association" "public-route-association-sub2" {
  route_table_id = aws_route_table.Public-route.id
  subnet_id      = aws_subnet.public-subnet2.id
}

resource "aws_route_table_association" "private-route-association-sub1" {
  route_table_id = aws_route_table.Private-route.id
  subnet_id      = aws_subnet.privte-subnet1.id
}
resource "aws_route_table_association" "private-route-association-sub2" {
  route_table_id = aws_route_table.Private-route.id
  subnet_id      = aws_subnet.privte-subnet2.id
}