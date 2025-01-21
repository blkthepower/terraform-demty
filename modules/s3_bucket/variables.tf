variable "aws_region" {
    description = "AWS Region for the bucket"
    type = string
    validation {
        condition = contains(["us-east-1"], var.aws_region)
        error_message = "Invalid region"
    }
}

variable "environment" {
    description = "The deployment environment"
    type = string
    validation {
        condition = contains(["dev", "prod", "staging"], var.environment)
        error_message = "Invalid environment"
    }
}

variable "bucket_name" {
    description = "Target S3 bucket name"
    type = string
    validation {
        condition = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
        error_message = "The bucket name must be between 3 and 63 characters."
    }
}

variable "web_index_file_name" {
    description = "File name of the index file used for the static web"
    type = string
    validation {
        condition = endswith(var.web_index_file_name, ".html")
        error_message = "The index file must be a valid HTML file"
    }
}

variable "web_error_file_name" {
    description = "File name of the error file used for the static web"
    type = string
    validation {
        condition = endswith(".html", var.web_error_file_name)
        error_message = "The error file must be a valid HTML file"
    }
}

variable "bucket_policy" {
    description = "JSON policies"
    type = string
}

variable "web_html" {
    description = "Web HTML file"
    type = object({
        path = string, 
        name = string,
    })
}

variable "web_css" {
    description = "Web CSS file"
    type = object({
        path = string, 
        name = string,
    })
}

variable "web_js" {
    description = "Web JavaScript file"
    type = object({
        path = string, 
        name = string,
    })
}

variable "block_public_access" {
    description = "Whether to block public access to the bucket or not"
    type = bool
}