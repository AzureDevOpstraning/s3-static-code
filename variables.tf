variable "aws_region" {
description = "AWS Region"
type = string
default = "us-east-1"
}


variable "bucket_name" {
description = "Name of the S3 bucket to create (must be globally unique)"
type = string
}