resource "aws_db_instance" "db-server" {
  lifecycle {
    ignore_changes = [
      username,
      password
    ]
  }
  identifier                  = local.identifier
  name                        = "db-server"
  username                    = local.master_username
  password                    = random_id.password.hex
  engine                      = "sqlserver-se"
  engine_version              = "13.00.5426.0.v1"
  license_model               = "license-included"
  instance_class              = "db.m3.2xlarge"
  allocated_storage           = 500
  multi_az                    = "false"
  port                        = 1433
  publicly_accessible         = "false"
  storage_type                = "gp2"
  storage_encrypted           = "true"
  db_subnet_group_name        = aws_db_subnet_group.db_subnet.id
  parameter_group_name        = aws_db_parameter_group.sqlserver.id
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  maintenance_window          = "sat:01:24-sat:01:54"
  allow_major_version_upgrade = "false"
  auto_minor_version_upgrade  = "true"
  backup_retention_period     = 5
  skip_final_snapshot         = "true"
  copy_tags_to_snapshot       = "true"

  tags = {
    Name            = "${local.app_name}-DB"
  }
}
resource "random_id" "password" {
  byte_length = 8
}



resource "aws_db_parameter_group" "sqlserver" {
    name    = "sqlserver-se-13"
    description = "Default parameter group for SQL Server 13.0 RDS instances"
    family  =  "sqlserver-se-13.0"

    parameter   = {
        name    = "rds.force_ssl"
        value   = "1"
        apply_method    = "pending-reboot"
    }
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "${lower(local.app_name)}-db-subnet"
  subnet_ids = [module.aws_core_infra.pri_sub1, module.aws_core_infra.pri_sub2]

  tags = {
    Name = "${lower(local.app_name)}-db-subnet"
  }
}