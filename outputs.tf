output "bucket_name" {
description = "S3 bucket name"
value = aws_s3_bucket.static_site.id
}


output "website_url" {
description = "S3 website endpoint"
value = aws_s3_bucket.static_site.website_endpoint
}