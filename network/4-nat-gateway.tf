resource "aws_eip" "nat-eip" {
  depends_on = [aws_internet_gateway.igw-xyz]
}



resource "aws_nat_gateway" "xyz-nat" {
  subnet_id         = aws_subnet.public-subnet1.id
  allocation_id     = aws_eip.nat-eip.id
  depends_on        = [aws_eip.nat-eip]
  connectivity_type = "public"
  tags = {
    Name = "nat-gateway-public"
  }

}
