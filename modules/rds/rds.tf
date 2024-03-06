resource "aws_db_parameter_group" "devops-rds-pg" {
  name   = "${var.name}-rds-pg"
  family = "sqlserver-se-12.0"

}


resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "sqlserver" {
  allocated_storage      = var.storage
  instance_class         = var.instance_class
  identifier             = "${var.name}-rds"
  username               = "admin"
  password               = "P@$$w0rD"
  engine                 = var.engine
  engine_version         = var.engine_version
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  vpc_security_group_ids = var.rds_sg
  parameter_group_name   = aws_db_parameter_group.devops-rds-pg.id
  maintenance_window     = var.maintenance_window
  multi_az               = false
  skip_final_snapshot    = true
  copy_tags_to_snapshot  = true
}

