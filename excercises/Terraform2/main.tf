variable "region" {
    description = "Region AWS"
    type = string
    validation {
        condition = contains(["us-east-1"], var.region)
        error_message = "Region incorrecta"
    }
}

variable "bucket_name" {
    description = "Nombre del bucket"
    type =  string
}

provider "aws" {
    region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = var.bucket_name
}