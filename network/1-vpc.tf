resource "aws_vpc" "vpc1" {
  enable_dns_support                   = true
  enable_dns_hostnames                 = true
  enable_network_address_usage_metrics = true
  cidr_block                           = "10.0.0.0/16"
  tags = {
    "Name" = "my-vpc"
    "org"  = "xyz-org"
  }

}

output "vpc" {
  value = aws_vpc.vpc1
}






