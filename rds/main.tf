

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
  lifecycle {

  }
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
  identifier                   = "aws-db"
  instance_class               = "db.t3.micro"
  engine                       = "postgres"
  engine_version               = "16.2"
  username                     = "postgres"
  password                     = "postgres"
  db_subnet_group_name         = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids       = [data.aws_security_group.public_security_group_id.id]
  parameter_group_name         = aws_db_parameter_group.db-parameter.name
  publicly_accessible          = true
  skip_final_snapshot          = true
  db_name                      = "app1Db"
  port                         = 5432
  allocated_storage            = 20 #GiB
  max_allocated_storage        = 1000
  deletion_protection          = true
  auto_minor_version_upgrade   = true
  performance_insights_enabled = true
  backup_retention_period      = 7 # 7 days The number of days (1-35) for which automatic backups are kept.
  backup_window                = "09:46-10:16"
  storage_type                 = "gp3"
  tags = {
    Name = "PostgreSQL v16.2"
  }
}
resource "aws_db_instance_automated_backups_replication" "backup-replication" {
  source_db_instance_arn = aws_db_instance.aws-db.arn
  retention_period       = 7
  depends_on             = [aws_db_instance.aws-db]
}

resource "aws_db_instance" "aws-db-replica" {
  allocated_storage          = 20 #GiB
  max_allocated_storage      = 1000
  backup_retention_period    = 7
  storage_type               = "gp3"
  identifier                 = "aws-db-replica"
  replicate_source_db        = aws_db_instance.aws-db.id
  auto_minor_version_upgrade = false
  replica_mode               = "mounted"
  instance_class             = "db.t3.micro"
  apply_immediately          = true
  publicly_accessible        = true
  skip_final_snapshot        = true
  vpc_security_group_ids     = [data.aws_security_group.public_security_group_id.id]
  parameter_group_name       = aws_db_parameter_group.db-parameter.name
  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }
  tags = {
    Name = "PostgreSQL v16.2-replica"
  }
}
