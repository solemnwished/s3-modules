module "s3_bucket" {
  source = "../s3"
  bucket_name = "ndn-${var.env}"
  bucket_acl  = "authenticated-read"
  tags = {
    Env = "${var.env}"
  }
}