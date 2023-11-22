module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = "assignment-vpc"
  cidr = var.vpc_cidr

  azs = [
    "eu-west-1a",
    "eu-west-1b",
  ]
  private_subnets = [
    "10.249.145.0/24",
    "10.249.146.0/24"
  ]
  public_subnets = [
    "10.249.144.0/24"
  ]

  enable_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}