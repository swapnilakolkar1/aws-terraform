resource "aws_internet_gateway" "igw-xyz" {
  vpc_id     = aws_vpc.vpc1.id
  depends_on = [aws_vpc.vpc1]
  tags = {
    "Name" = "igw-xyz"
    "org"  = "xyz-org"
  }
}