output "name" {
  description = "S3's ID"
  value       = aws_s3_bucket.my_bucket.id
}