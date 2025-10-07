output "bucket_name" {
  value = aws_s3_bucket.this.id
}

output "website_url" {
  value = aws_s3_bucket.this.website_endpoint
}
