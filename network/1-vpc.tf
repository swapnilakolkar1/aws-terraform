resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "my-vpc"
    "org"  = "xyz-org"
  }
}

output "vpc" {
  value = aws_vpc.vpc1
}






