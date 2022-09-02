module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "ndn-alb-${var.env}"

  load_balancer_type = "application"

  vpc_id             = "vpc-0bad1f285cdd3d792"
  subnets            = ["subnet-0c2fc975f8826a252", "subnet-0428294ea97df5ae5"]
  security_groups    = ["sg-066862f0bbb1b91ed", "sg-066862f0bbb1b91ed"]

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
          target_id = "i-06d6a89a1d72d1465"
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
    Environment = "${var.env}"
  }
}
