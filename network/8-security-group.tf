resource "aws_security_group" "app1-sg-public-resource" {
  name                   = "app1-security-group"
  description            = "This security group is for public resources of application1 "
  vpc_id                 = aws_vpc.vpc1.id
  depends_on             = [aws_vpc.vpc1]
  revoke_rules_on_delete = true
  tags = {
    Name = "app1-security-group"
  }
}
resource "aws_security_group_rule" "allow-ssh" {
  security_group_id = aws_security_group.app1-sg-public-resource.id
  type              = "ingress"
  description       = "allow SSH from anywhere"
  protocol          = "tcp"
  to_port           = 22
  from_port         = 22
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow-http" {
  security_group_id = aws_security_group.app1-sg-public-resource.id
  type              = "ingress"
  description       = "allow http from anywhere"
  protocol          = "tcp"
  to_port           = 80
  from_port         = 80
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "allow-https" {
  security_group_id = aws_security_group.app1-sg-public-resource.id
  type              = "ingress"
  description       = "allow https from anywhere"
  protocol          = "tcp"
  to_port           = 443
  from_port         = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow-postgres" {
  security_group_id = aws_security_group.app1-sg-public-resource.id
  type              = "ingress"
  description       = "allow-postgres  connection  from anywhere"
  protocol          = "tcp"
  to_port           = 5432
  from_port         = 5432
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow-all" {
  security_group_id = aws_security_group.app1-sg-public-resource.id
  type              = "egress"
  description       = "allow all outboud traffic"
  protocol          = -1            #any protocol all trafic 'type'
  to_port           = 0             #all port range
  from_port         = 0             #all protocol
  cidr_blocks       = ["0.0.0.0/0"] # destination
}