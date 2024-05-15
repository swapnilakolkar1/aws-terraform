# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.Public-route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw-xyz.id
}

# Route for NAT Gateway
resource "aws_route" "private_internet_gateway" {
  route_table_id         = aws_route_table.Private-route.id
  gateway_id             = aws_nat_gateway.xyz-nat.id
  destination_cidr_block = "0.0.0.0/0"
}

