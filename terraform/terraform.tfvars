aws_region             = "eu-west-1"
aws_account_id         = "070496647552"
vpc_cidr               = "10.249.144.0/20"
rds_username           = "db_user_iam"
rds_dbname             = "assignmentdb"
db_instance_identifier = "assignment-rds"

tags = {
  "created_by" = "terraform"
  "env"        = "dev"
  "team"       = "devops"
  "function"   = "assignment"
}