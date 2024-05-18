data "aws_vpc" "vpc1" {
  filter {
    name   = "tag:Name"
    values = ["my-vpc"]
  }
}

data "aws_subnet" "public-subnet1" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet1"]
  }
}

data "aws_security_group" "public-security_group_id" {
  filter {
    name   = "tag:Name"
    values = ["app1-security-group"]
  }
}

output "vpc" {
  value = data.aws_vpc.vpc1
}

resource "aws_instance" "my_instance1" {
  ami             = "ami-04b70fa74e45c3917" # Canonical, Ubuntu, 24.04 LTS, amd64 noble image build on 2024-04-23
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.public-subnet1.id
  vpc_security_group_ids = [data.aws_security_group.public-security_group_id.id] #without security group can not connect to ec2 ssh port needs to be open for 0.0.0.0/0
  key_name        = aws_key_pair.kp.key_name # Replace with your SSH key pair name
  depends_on      = [aws_key_pair.kp]
  tags = {
    Name = "react-application-ec2"
  }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "ec2-key"
  public_key = tls_private_key.pk.public_key_openssh

}

resource "local_file" "ssh_key-pem" {
  filename = "${aws_key_pair.kp.key_name}.pem"
  content  = tls_private_key.pk.private_key_pem
}

resource "local_file" "ssh_key-ppk" {
  filename = "${aws_key_pair.kp.key_name}.ppk"
  content  = tls_private_key.pk.private_key_openssh
}
