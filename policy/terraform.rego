package terraform.s3


deny[msg] {
resource := input.planned_values.root_module.resources[_]
resource.type == "aws_s3_bucket"
not startswith(resource.values.bucket, "dev-")
msg = sprintf("S3 bucket name '%s' does not start with 'dev-'", [resource.values.bucket])
}


deny[msg] {
resource := input.planned_values.root_module.resources[_]
resource.type == "aws_s3_bucket"
not resource.values.tags.Environment
msg = sprintf("S3 bucket '%s' does not have tags.Environment set", [resource.values.bucket])
}