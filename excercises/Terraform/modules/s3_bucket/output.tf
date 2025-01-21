output "bucket_arn" {
    description = "El arn del bucket de s3"
    value = aws_s3_bucket.this.arn
}