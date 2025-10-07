terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3_static_website" {
  source      = "./modules/s3_static_website"
  bucket_name = var.bucket_name
  index_file  = var.index_file
  tags        = {
    Environment = "dev"
    Project     = "HelloWorldSite"
  }
}

output "website_url" {
  value = module.s3_static_website.website_url
}
