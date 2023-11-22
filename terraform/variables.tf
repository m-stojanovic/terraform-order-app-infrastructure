variable "aws_region" {}
variable "aws_account_id" {}
variable "vpc_cidr" {}
variable "tags" {}
variable "db_instance_identifier" {}
variable "rds_username" {}
variable "rds_dbname" {}
variable "rds_password" { sensitive = true }