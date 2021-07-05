TERRAFORM_DOCKER_IMAGE=hashicorp/terraform:1.0.0
TERRAFORM_LINTER_IMAGE=wata727/tflint

init:
	docker run --rm -v ${PWD}:/aws_twizar -w /aws_twizar -i -t $(TERRAFORM_DOCKER_IMAGE) init
plan:
	docker run --rm -v ${PWD}:/aws_twizar -w /aws_twizar -i -t $(TERRAFORM_DOCKER_IMAGE) plan
apply:
	docker run --rm -v ${PWD}:/aws_twizar -w /aws_twizar -i -t $(TERRAFORM_DOCKER_IMAGE) apply
destroy:
	docker run --rm -v ${PWD}:/aws_twizar -w /aws_twizar -i -t $(TERRAFORM_DOCKER_IMAGE) destroy
lint:
	docker run --rm -v ${PWD}:/data -t $(TERRAFORM_LINTER_IMAGE)
