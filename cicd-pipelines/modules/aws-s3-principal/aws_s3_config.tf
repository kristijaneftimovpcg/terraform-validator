# S3 Bucket
resource "aws_s3_bucket" "bucket" {
  force_destroy = true
  bucket        = var.bucket_name
  tags          = var.tags
}

# S3 Bucket policy with the principal role arn
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.principal_role_arn
        },
        Action = [
          "s3:Get*",
          "s3:List*",
          "s3:ReplicateObject",
          "s3:PutObject",
          "s3:RestoreObject",
          "s3:PutObjectVersionTagging",
          "s3:PutObjectTagging",
          "s3:PutObjectAcl"
        ],
        Resource = [
          aws_s3_bucket.bucket.arn,
          "${aws_s3_bucket.bucket.arn}/*",
        ],
      },
    ],
  })
}

# S3 Bucket ACL ownership
resource "aws_s3_bucket_ownership_controls" "bucket_acl_ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = var.enable_acl ? "BucketOwnerPreferred" : "BucketOwnerEnforced"
  }
}

# S3 Bucket  ACL
resource "aws_s3_bucket_acl" "bucket_acl" {
  count      = var.enable_acl ? 1 : 0
  bucket     = aws_s3_bucket.bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.bucket_acl_ownership]
}
