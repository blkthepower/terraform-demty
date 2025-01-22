variable "aws_region" {
  description = "AWS Region for the bucket"
  type        = string
  validation {
    condition     = contains(["us-east-1"], var.aws_region)
    error_message = "Invalid region"
  }
}

variable "environment" {
  description = "The deployment environment"
  type        = string
  validation {
    condition     = contains(["dev", "prod", "staging"], var.environment)
    error_message = "Invalid environment"
  }
}