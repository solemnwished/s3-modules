#Create SSH keypair
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "prod" {
  key_name = "prod-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDL4sS2hNljVOw1Tf1RSlkqFDDeYJclXoT5ZPSujIYfdC2WY0olkMbyjrx+xnyJC5JXM7BVkLMrs5yAhgdDcQRU+cdWImS3mS/0M7fHNT7Gr9aV9s87oqGgP8XSXsRGvLdP79ySed5SsXOJa06Hz4VTD2jW3iRquxLo4JuS+DIZtzUHoWQEQv6Q81wT5ya1rIq0Q4QuUztVlwvOgOohiFFCWIiTeaSYpsVkYVTDREAh/13FpbbjR8OxUfxp3RhuCQ15Tg6XizrHDE6+0GMaqdWUroIk+6QeyZFQ5cHR5KbFvY1c9PYbwmYYmr4ITSu+2nb3JQ034lYwAoUkJFqA44z2YPVYO376f9PIY8OaUkmZ0Vr9FVgI8WTGceoUQXbiK9WsG17m/IGQKWyJVTocHb1LD8UU/FF2SmRuGUp8ZDgm8NVUVtOt9DaCum2yWFsb6kCGwrQFSppiE0bj6ubyFktFfvke4/tHYdtGQd7bFZ35JeIiajOe8qdaQXLsVHxbLyHTRZC3Me7gE7b8j4f/j/SLcsQoz95fl2UFMJavdDwsd9i+ilN/hTDoW3Al6oarICaOHZDMZyHJ4P+3LQ5j7kPaFxOCy3zRuS7RVfx1QL+adkEooGPz8a3sQjwKU5kD7pooLdB2iLWAajBfK2KKN4ZtjDUz4pQiLRPIg/p0Of7yiw== ndn@handup"

}

#Create EC2 instance
#AMI: https://cloud-images.ubuntu.com/locator/ec2/
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  name = "web-instance-${var.env}"
  ami = "ami-0eaf04122a1ae7b3b"
  instance_type = "t2.micro"
  key_name = aws_key_pair.prod.key_name
  vpc_security_group_ids = [module.ec2_security_group.security_group_id]
  subnet_id = element(module.vpc.public_subnets, 0)
  tags = {
    Terraform = "true"
    Environment = "${var.env}"
  }
}

#Create SEC_GROUP
module "ec2_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  
  name = "web-security-group-${var.env}"
  description = "Security group for Web ec2 instances"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["http-80-tcp","all-icmp","ssh-tcp"]
  egress_rules = ["all-all"]
}