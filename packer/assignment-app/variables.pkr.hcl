variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_name" {
  type    = string
  default = "assignment-node"
}

variable "ami_users" {
  type    = list(string)
  default = ["070496647552"]
}

variable "username" {
  type    = string
  default = "ec2-user"
}

variable "subnet_id" {
  type    = string
  default = "subnet-c81934ae"
}

variable "security_group_id" {
  type    = string
  default = "sg-06c01f47"
}

variable "vpc_id" {
  type    = string
  default = "vpc-170dfd6e"
}

variable "tags" {
  default = {
    "created_by" = "packer"
    "env"        = "dev"
    "team"       = "devops"
    "function"   = "assignment"
  }
}