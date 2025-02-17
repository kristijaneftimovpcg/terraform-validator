output "s3_bucket" {
  value       = aws_s3_bucket.bucket.bucket
  description = "S3 bucket"
}

output "s3_bucket_id" {
  value       = aws_s3_bucket.bucket.id
  description = "S3 bucket ID"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "S3 bucket ARN"
}
