=====================
File contents

Important: Do not blindly copy/paste into a production account. This example creates a public S3 bucket (intended for static website hosting). For production, consider CloudFront + OAI and stricter controls.

========================

============

policy/terraform.rego (Conftest OPA policy)

This policy demonstrates a few simple checks:

Bucket name must start with dev- (example requirement)

Bucket must set tags containing Environment.

==========

====================

Notes:

Conftest reads the Terraform plan JSON (terraform show -json). The layout used above (planned_values.root_module.resources) matches the Terraform plan JSON structure.
=======================

=================================

Step-by-step run (example)

Edit variables.tf or pass BUCKET_NAME on the Make command line. Bucket name must be globally unique (e.g. dev-hello-world-example-12345).

Initialize Terraform:

make init

Format and validate:

make fmt
make validate

Create a plan and export it to plan.json and run Conftest:

make plan BUCKET_NAME=dev-hello-world-example-12345
make show-plan-json
make conftest

If Conftest fails, fix the Terraform code or the values to satisfy your policy.

Apply the configuration:

make apply BUCKET_NAME=dev-hello-world-example-12345

Terraform outputs include website_url. Example returned endpoint:

my-bucket.s3-website-us-east-1.amazonaws.com

Verify manually by opening the website_url in a browser — you should see Hello World from S3!

Run the automated Terratest (post-functional) test (this will run terraform init/apply again inside the test unless you modify the test options):

make test

Destroy the environment when finished:

make destroy BUCKET_NAME=dev-hello-world-example-12345
make clean
Demonstration checklist for your team lead




Notes & Suggestions

For production, avoid making the bucket public. Use CloudFront + Origin Access Identity (or OAC) and restrict bucket policy to CloudFront only.

Conftest policies should be adjusted to reflect your org gates (naming convention, tags, public access rules, cost controls, etc.).

Terratest tests may take time to run as they perform infrastructure actions. Set appropriate timeouts and use t.Parallel() strategically.

If you want, I can:

Generate a cloudfront + acm example in Terraform to front the S3 site.

Add an IAM policy and an automation script to request sandbox admin access after Conftest passes.

Customize Conftest policies to match your org's naming/tagging guidelines.

Tell me which of those you'd like next.

==================================


