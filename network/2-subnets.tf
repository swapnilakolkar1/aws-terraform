
resource "aws_subnet" "public-subnet1" {
  vpc_id = aws_vpc.vpc1.id

  availability_zone       = "us-east-1a" # us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1e, us-east-1f
  cidr_block              = "10.0.1.0/24"
  depends_on              = [aws_vpc.vpc1]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-subnet1"
    "org"  = "xyz-org"
  }
}
output "public-subnet-1" {
  value = {
    "Name" = aws_subnet.public-subnet1.id
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id = aws_vpc.vpc1.id

  availability_zone       = "us-east-1b" # us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1e, us-east-1f
  cidr_block              = "10.0.2.0/24"
  depends_on              = [aws_vpc.vpc1]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-subnet2"
    "org"  = "xyz-org"
  }
}






resource "aws_subnet" "privte-subnet1" {
  vpc_id = aws_vpc.vpc1.id

  availability_zone       = "us-east-1a" # us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1e, us-east-1f
  cidr_block              = "10.0.3.0/24"
  depends_on              = [aws_vpc.vpc1]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "privte-subnet1"
    "org"  = "xyz-org"
  }
}

resource "aws_subnet" "privte-subnet2" {
  vpc_id = aws_vpc.vpc1.id

  availability_zone       = "us-east-1b" # us-east-1a, us-east-1b, us-east-1c, us-east-1d, us-east-1e, us-east-1f
  cidr_block              = "10.0.4.0/24"
  depends_on              = [aws_vpc.vpc1]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "privte-subnet2"
    "org"  = "xyz-org"
  }
}