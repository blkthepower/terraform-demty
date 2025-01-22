# terraform-demty
Implements a module with all the terraform related things learned during the DE MTY 2025 BootCamp (BC)

# Terraform Configuration for S3 Bucket Setup

This Terraform configuration practice sets up an AWS S3 bucket with a custom bucket policy, web files (HTML, CSS, JS) and public access.

The configuration applies most of what was taught during the BC:

- File structure (main, outputs, providers, variables, tfvars)
- File uploading from Terraform
- Variables definition
- Variables conditions
- Policies
- Static web hosting
- Outputs

Also learned during the BC but not visible here:

- TF init
- TF plan
- TF apply
- TF refresh
- TF destroy
- TF states: local and remote


## Excercises

In the 'excercises' directory you can find the TF activities performed during the BC.

## Variables

The following variables are required to run the configuration:

### `aws_region`
- **Type**: `string`
- **Description**: Specifies the AWS region where the resources will be created.
- **Default**: us-east-1
  
### `environment`
- **Type**: `string`
- **Description**: The environment name (e.g., `dev`, `prod`, etc.) used to differentiate resources.
- **Default**: dev

### `source`
- **Type**: `string`
- **Description**: Path to the module that will manage the S3 bucket. This should point to the directory where the `s3_bucket` module is located.
- **Default**: `./modules/s3_bucket`

### `bucket_name`
- **Type**: `string`
- **Description**: The base name for the S3 bucket.
- **Example**: `xideraloscar-bucket-tf-practice`

### `web_index_file_name`
- **Type**: `string`
- **Description**: Name of the web index file (typically `index.html`). If this value is changed, make sure to also update `web_html`
- **Example**: `index.html`

### `web_error_file_name`
- **Type**: `string`
- **Description**: Name of the web error file (typically `error.html`).
- **Example**: `error.html`

### `bucket_policy`
- **Type**: `string`
- **Description**: A JSON-formatted policy applied to the S3 bucket. This policy defines which actions are allowed (e.g., `s3:GetObject`) and specifies the resources (e.g., the bucket ARN). It is encoded using `jsonencode`.
- **Example**: 
  ```json
  {
    "Version": "2012-10-17",
    "Id": "HTTP referer policy example",
    "Statement": [
      {
        "Sid": "AllowOnlySpecificReferers",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ],
        "Resource": "${module.s3_bucket.bucket_arn}/*"
      }
    ]
  }

### `web_html`
- **Type**: `object`
- **Description**: Specifies the file that will be uploaded and used for the web page: Requires a `path` and the desired `name` of the file once uploaded.
- **Default**: The file found in `web_files`

### `web_css`
- **Type**: `object`
- **Description**: Specifies the file that will be uploaded and used for the web page's style: Requires a `path` and the desired `name` of the file once uploaded.
- **Default**: The file found in `web_files`

### `web_js`
- **Type**: `object`
- **Description**: Specifies the file that will be uploaded and used for the web page's javascript: Requires a `path` and the desired `name` of the file once uploaded.
- **Default**: The file found in `web_files`

### `block_public_access`
- **Type**: `bool`
- **Description**: Whether block or not all the public access to the S3 bucket. This should always be `true` as it's required for the policies (it was only added to experiment with bool variables)

