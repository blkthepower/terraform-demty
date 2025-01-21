provider "aws" {
    region = "us-east-1"
}

module "s3_bucket" {
    source = "./modules/s3_bucket"
    bucket_name = "xideraloscarterraformbucketpolicy"
    bucket_policy = jsonencode({
    Version = "2012-10-17",
    Id      = "HTTP referer policy example",
    Statement = [
    {
        Sid       = "AllowOnlySpecificReferers",
        Effect    = "Allow",
        Principal = "*",
        Action    = [
            "s3:GetObject",
            "s3:GetObjectVersion"
        ],
        Resource = "arn:aws:s3:::xideraloscarterraformbucketpolicy/*",
    }]
    })
}