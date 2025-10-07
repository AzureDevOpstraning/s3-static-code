init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

test:
	go test ./test -v

fmt:
	terraform fmt -recursive
