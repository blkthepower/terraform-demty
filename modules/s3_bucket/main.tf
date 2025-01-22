resource "aws_s3_bucket" "main_bucket"{
	bucket = "${var.bucket_name}-${var.environment}"
	tags = {
		Name = "Example bucket from terraform"
	}
}

resource "aws_s3_bucket_public_access_block" "main_bucket_access_block"{
	bucket = aws_s3_bucket.main_bucket.id

	block_public_acls       = var.block_public_access
	block_public_policy     = var.block_public_access
	ignore_public_acls      = var.block_public_access
	restrict_public_buckets = var.block_public_access
}

resource "aws_s3_bucket_website_configuration" "main_bucket_static_website" {
	bucket = aws_s3_bucket.main_bucket.id

	index_document {
		suffix = var.web_index_file_name
	}

	error_document {
		key = var.web_error_file_name
	}
}

resource "aws_s3_bucket_policy" "main_bucket_policy" {
	bucket = aws_s3_bucket.main_bucket.id
    depends_on = [ aws_s3_bucket_public_access_block.main_bucket_access_block ]

	policy = var.bucket_policy
}

resource "aws_s3_object" "web_index" {
	bucket = aws_s3_bucket.main_bucket.id
	key = var.web_html.name
    source = var.web_html.path
	content_type = "text/html"
	etag = filemd5(var.web_html.path)
}

resource "aws_s3_object" "web_css" {
	bucket = aws_s3_bucket.main_bucket.id
    key = var.web_css.name
    source = var.web_css.path
	content_type = "text/css"
	etag = filemd5(var.web_css.path)
}

resource "aws_s3_object" "web_js" {
	bucket = aws_s3_bucket.main_bucket.id
    key = var.web_js.name
    source = var.web_js.path
	content_type = "application/javascript"
	etag = filemd5(var.web_js.path)
}
