variable "bucket_name" {
  description = "S3 bucket name for static website"
  type        = string
}

variable "index_file" {
  description = "Path to index.html file"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
