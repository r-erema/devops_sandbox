install:
	helm repo add vm https://victoriametrics.github.io/helm-charts/
	helm repo update
	kubectl create namespace vm --dry-run=client -o yaml | kubectl apply -f -
	helm upgrade -i vm-stack vm/victoria-metrics-k8s-stack -f vm_stack_values.yaml -n vm

delete:
	helm delete vm-cluster vm-stack -n vm