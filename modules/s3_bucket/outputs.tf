output "bucket_name" {
    description = "Created Bucket"
    value = aws_s3_bucket.main_bucket.bucket
}

output "bucket_arn" {
    description = "Created Bucket ARN"
    value = aws_s3_bucket.main_bucket.arn
}

output "bucket_public_access_status" {
    description = "Is public access blocked"
    value = var.block_public_access
}

output "web_home_page" {
    value = "https://${aws_s3_bucket.main_bucket.bucket}.s3.amazonaws.com/${aws_s3_object.web_index.key}"
}
