
module "s3_bucket" {
  aws_region          = var.aws_region
  environment         = var.environment
  source              = "./modules/s3_bucket"
  bucket_name         = "xideraloscar-bucket-tf-practice"
  web_index_file_name = "index.html"
  web_error_file_name = "error.html"
  bucket_policy = jsonencode(
    {
      Version = "2012-10-17",
      Id      = "HTTP referer policy example",
      Statement = [
        {
          Sid       = "AllowOnlySpecificReferers",
          Effect    = "Allow",
          Principal = "*",
          Action = [
            "s3:GetObject",
            "s3:GetObjectVersion"
          ],
          Resource = "${module.s3_bucket.bucket_arn}/*",
        }
      ]
    }
  )
  web_html = {
    path = ".\\web_files\\index.html",
    name = "index.html",
  }
  web_css = {
    path = ".\\web_files\\style.css"
    name = "style.css"
  }
  web_js = {
    path = ".\\web_files\\function.js"
    name = "function.js"
  }
  block_public_access = false
}


output "s3_bucket" {
    value = module.s3_bucket
}