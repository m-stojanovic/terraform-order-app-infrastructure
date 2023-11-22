resource "aws_db_instance" "assignment-rds" {
  allocated_storage                   = 20
  storage_type                        = "gp2"
  engine                              = "postgres"
  engine_version                      = 12.17
  instance_class                      = "db.t2.micro"
  db_name                             = var.rds_dbname
  identifier                          = var.db_instance_identifier
  username                            = "dbuser"
  password                            = var.rds_password
  parameter_group_name                = aws_db_parameter_group.assignment-parameter-group.name
  skip_final_snapshot                 = true
  vpc_security_group_ids              = [aws_security_group.assignment-rds-sg.id]
  db_subnet_group_name                = aws_db_subnet_group.assignment-db-subnet-group.name
  iam_database_authentication_enabled = true
  
  tags                                = merge(tomap({ "Name" = "assignment-server" }), var.tags)
}

resource "aws_db_parameter_group" "assignment-parameter-group" {
  name        = "assignment-parameter-group"
  family      = "postgres12"
  description = "Custom parameter group for PostgreSQL"

  parameter {
    name         = "rds.force_ssl"
    value        = "1"
    apply_method = "immediate"
  }
}

resource "aws_db_subnet_group" "assignment-db-subnet-group" {
  name       = "assignment-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = merge(tomap({ "Name" = "assignment-db-subnet-group" }), var.tags)
}


resource "aws_security_group" "assignment-rds-sg" {
  name        = "assignment-rds-sg"
  description = "Security group to allow access to assignment server."
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "allow access from vpc on port 5432"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    description     = "allow access from EC2 instances on port 5432"
    security_groups = [aws_security_group.assignment-ec2-sg.id]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "allow access to vpc on port 5432"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = merge(tomap({ "Name" = "assignment-rds-sg" }), var.tags)
}