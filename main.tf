resource "aws_s3_bucket" "static_site" {
bucket = var.bucket_name
acl = "public-read" # public so website can be served directly


website {
index_document = "index.html"
error_document = "index.html"
}


tags = {
Name = "HelloWorldStaticSite"
Environment = "dev"
}
}


resource "aws_s3_bucket_ownership_controls" "ownership" {
bucket = aws_s3_bucket.static_site.id
rule {
object_ownership = "BucketOwnerPreferred"
}
}


resource "aws_s3_bucket_public_access_block" "public_access" {
bucket = aws_s3_bucket.static_site.id


block_public_acls = false
block_public_policy = false
ignore_public_acls = false
restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "public_policy" {
bucket = aws_s3_bucket.static_site.id
policy = jsonencode({
Version = "2012-10-17",
Statement = [
{
Sid = "PublicReadGetObject",
Effect = "Allow",
Principal = "*",
Action = ["s3:GetObject"],
Resource = "${aws_s3_bucket.static_site.arn}/*"
}
]
})
}


resource "aws_s3_bucket_object" "index" {
bucket = aws_s3_bucket.static_site.id
key = "index.html"
source = "index.html"
content_type = "text/html"
acl = "public-read"
}