

data "aws_subnet" "public-subnet1" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet1"]
  }
}

data "aws_subnet" "public-subnet2" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet2"]
  }
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [data.aws_subnet.public-subnet1.id, data.aws_subnet.public-subnet2.id]
  tags = {
    Name = "db-subnet-group"
  }
}

data "aws_security_group" "public_security_group_id" {
  filter {
    name   = "tag:Name"
    values = ["app1-security-group"]
  }
}

resource "aws_db_parameter_group" "db-parameter" {
  name        = "aws-postgres16-family"
  family      = "postgres16"
  description = "postgres 16 parameter group"
  parameter {
    name  = "log_connections"
    value = "1"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_db_instance" "aws-db" {

  identifier             = "aws-db"
  instance_class         = "db.t3.micro"
  engine                 = "postgresql"
  engine_version         = "16.2"
  username               = "postgres"
  password               = "postgres"
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [data.aws_security_group.public_security_group_id.id]
  parameter_group_name   = aws_db_parameter_group.db-parameter.name
  publicly_accessible    = true
  skip_final_snapshot    = true
  tags = {
    Name = "PostgreSQL v16.2"
  }
  db_name                      = "aws-db"
  port                         = 5432
  allocated_storage            = 20 #GiB
  max_allocated_storage        = 100
  deletion_protection          = true
  auto_minor_version_upgrade   = true
  performance_insights_enabled = true

}

# resource "aws_db_instance" "aws-db-replica" {
#   identifier             = "aws-db-replica"
#   replicate_source_db    = aws_db_instance.aws-db.identifier
#   instance_class         = "db.r5.large"
#   apply_immediately      = true
#   publicly_accessible    = true
#   skip_final_snapshot    = true
#   vpc_security_group_ids = [data.aws_security_group.public_security_group_id.id]
#   parameter_group_name   = aws_db_parameter_group.db-parameter.name
#   tags = {
#     Name = "Aurora (PostgreSQL) v15.4 -replica"
#   }
# }
