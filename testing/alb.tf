module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "ndn-alb-${var.env}"

  load_balancer_type = "application"

  vpc_id             = "vpc-0fd9326afa480c2c8"
  subnets            = ["subnet-0deae1e4599021132", "subnet-0d96daf7187936af5"]
  security_groups    = ["sg-0f9d23348623e6d8a", "sg-0f9d23348623e6d8a"]

#  access_logs = {
#    bucket = "ndn-${var.env}"
#  }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-032018cdcef43e44d"
          port = 80
        }
        # my_other_target = {
        #   target_id = "i-a1b2c3d4e5f6g7h8i"
        #   port = 8080
        # }
      }
    }
  ]

#   https_listeners = [
#     {
#       port               = 443
#       protocol           = "HTTPS"
#       certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
#       target_group_index = 0
#     }
#   ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}
