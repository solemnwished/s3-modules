module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "ndn-${var.env}"
  cidr = "10.0.0.0/16"

  azs = ["ap-southeast-1a","ap-southeast-1b"]
  public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24","10.0.102.0/24"]
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}