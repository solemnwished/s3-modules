module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "ndn-${var.env}"
  cidr = "10.10.0.0/16"

  azs = ["ap-southeast-1a","ap-southeast-1b"]
  public_subnets = ["10.10.3.0/24","10.10.4.0/24"]
  private_subnets = ["10.10.110.0/24","10.10.111.0/24"]
  tags = {
    Terraform = "true"
    Environment = "${var.env}"
  }
}