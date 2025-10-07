SHELL := /bin/bash


init:
terraform init


fmt:
terraform fmt -recursive


validate:
terraform validate


plan:
terraform plan -var="bucket_name=$(BUCKET_NAME)" -out=tfplan.binary


show-plan-json: plan
terraform show -json tfplan.binary > plan.json


conftest: show-plan-json
conftest test plan.json -p policy || (echo "Conftest failed" && exit 1)


apply:
terraform apply -auto-approve -var="bucket_name=$(BUCKET_NAME)"


test: init
cd test && go test -v


destroy:
terraform destroy -auto-approve -var="bucket_name=$(BUCKET_NAME)"


clean:
rm -f tfplan.binary plan.json