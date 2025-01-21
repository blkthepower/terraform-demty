provider "aws" {
	region = "us-east-1"
}

resource "aws_s3_bucket" "main_bucket"{
	bucket = "examplebucketoscarxideral3"
	tags = {
		Name = "example bucket from terraform"
	}
}


resource "aws_s3_bucket_public_access_block" "main_bucket_access_block"{
	bucket = aws_s3_bucket.main_bucket.id

	block_public_acls       = false
	block_public_policy     = false
	ignore_public_acls      = false
	restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "main_bucket_static_website" {
	bucket = aws_s3_bucket.main_bucket.id

	index_document {
		suffix = "index.html"
	}

	error_document {
		key = "error.html"
	}
}

resource "aws_s3_bucket_policy" "main_bucket_policy" {
	bucket = aws_s3_bucket.main_bucket.id

	policy = jsonencode({
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
			Resource = "${aws_s3_bucket.main_bucket.arn}/*",
		}
		]
	})
}

resource "aws_s3_object" "web_index" {
	bucket = aws_s3_bucket.main_bucket.id
	key = "index.html"
	source = "C:\\Users\\VOSTRO 3400\\Documents\\Xideral DE MTY\\Web Test S3\\index.html"
	etag = filemd5("C:\\Users\\VOSTRO 3400\\Documents\\Xideral DE MTY\\Web Test S3\\index.html")
	content_type = "text/html"
	content_disposition = ""
}

resource "aws_s3_object" "web_css" {
	bucket = aws_s3_bucket.main_bucket.id
	key ="style.css"
	source = "C:\\Users\\VOSTRO 3400\\Documents\\Xideral DE MTY\\Web Test S3\\style.css"
	content_type = "text/css"
	etag = filemd5("C:\\Users\\VOSTRO 3400\\Documents\\Xideral DE MTY\\Web Test S3\\style.css")
}

resource "aws_s3_object" "web_js" {
	bucket = aws_s3_bucket.main_bucket.id
	key = "function.js"
	source = "C:\\Users\\VOSTRO 3400\\Documents\\Xideral DE MTY\\Web Test S3\\function.js"
	content_type = "application/javascript"
	etag = filemd5("C:\\Users\\VOSTRO 3400\\Documents\\Xideral DE MTY\\Web Test S3\\function.js")
}
