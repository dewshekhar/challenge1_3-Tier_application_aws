
#Application Server SG

resource "aws_security_group" "sg" {
  name        = "${local.app_name}-WEB-SERVER-SG"
  description = "Security Group For MEDIAWIKI Web Server"
  vpc_id      = module.aws_core_infra.vpc_id
  tags = {
    Name = "${local.app_name}-WEB-SERVER-SG"
  }
  ingress {
    description     = "Allow 80 port from lb"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }
  ingress {
    description     = "Allow 80 port from app server"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Load Balancer SG

resource "aws_security_group" "lb_sg" {
  name        = "${local.app_name}-ALB-SG"
  description = "Security Group For load balancer"
  vpc_id      = module.aws_core_infra.vpc_id
  tags = {
    Name = "${local.app_name}-ALB-SG"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name        = "${local.app_name}-APP-SERVER-SG"
  description = "Security Group For MEDIAWIKI Web Server"
  vpc_id      = module.aws_core_infra.vpc_id
  tags = {
    Name = "${local.app_name}-APP-SERVER-SG"
  }
  ingress {
    description     = "Allow 80 port from web server"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.sg.id]
  }
  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name        = "${local.app_name}-DB-SERVER-SG"
  description = "Security Group For MEDIAWIKI Web Server"
  vpc_id      = module.aws_core_infra.vpc_id
  tags = {
    Name = "${local.app_name}-DB-SERVER-SG"
  }
  ingress {
    description     = "Allow 1433 port from app server"
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
  ingress {
    description = "Allow ssh"
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}