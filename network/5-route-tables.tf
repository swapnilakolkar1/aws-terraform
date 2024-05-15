resource "aws_route_table" "Public-route" {
  vpc_id     = aws_vpc.vpc1.id
  depends_on = [aws_vpc.vpc1, aws_internet_gateway.igw-xyz, aws_subnet.public-subnet1, aws_subnet.public-subnet2]
  tags = {
    Name = "Public-route"
  }
}
resource "aws_route_table" "Private-route" {
  vpc_id     = aws_vpc.vpc1.id
  depends_on = [aws_vpc.vpc1, aws_internet_gateway.igw-xyz, aws_subnet.privte-subnet1, aws_subnet.privte-subnet2]
  tags = {
    Name = "Private-route"
  }
}
