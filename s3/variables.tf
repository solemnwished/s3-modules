variable "bucket_name" {
  description = "Name of S3's bucket."
  type        = string
}

variable "bucket_acl" {
  description = "ACL apply to bucket."
  type = string
}

variable "tags" {
  description = "S3's Tag."
  type        = map(string)
  default     = {}
}