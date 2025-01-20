K8S_VERSION=v1.29.0

MANAGING_CLUSTER_NAME=managing-cluster

MANAGED_CLUSTER_NAME=managed-cluster
MANAGED_CLUSTER_MANIFESTS_FILE=${MANAGED_CLUSTER_NAME}.yaml

kind-cluster: prepare-system
	kind create cluster --image=kindest/node:${K8S_VERSION} --name ${MANAGING_CLUSTER_NAME} --config kind-cluster-with-extramounts.yaml

init-capi-management-cluster:
	EXP_RUNTIME_SDK=true \
	CLUSTER_TOPOLOGY=true \
	SERVICE_CIDR=["10.96.0.0/12"] \
	POD_CIDR=["192.168.0.0/16"] \
	SERVICE_DOMAIN="k8s.test" \
	clusterctl --kubeconfig-context kind-${MANAGING_CLUSTER_NAME} init --infrastructure docker

vm:
	helm repo add vm https://victoriametrics.github.io/helm-charts/
	helm repo update
	kubectl --context kind-${MANAGING_CLUSTER_NAME} create ns vm --dry-run=client -o yaml | kubectl apply -f -
	helm --kube-context kind-${MANAGING_CLUSTER_NAME} upgrade -i vm-stack vm/victoria-metrics-k8s-stack -f victoria_metrics/vm_stack_values.yaml -n vm

generate-managed-cluster-manifests:
	clusterctl --kubeconfig-context kind-${MANAGING_CLUSTER_NAME} generate cluster ${MANAGED_CLUSTER_NAME} --flavor development \
		--kubernetes-version ${K8S_VERSION} \
		--control-plane-machine-count 1 \
		--worker-machine-count 2 \
		--target-namespace ${MANAGED_CLUSTER_NAME} \
		> ${MANAGED_CLUSTER_MANIFESTS_FILE}

deploy-managed-cluster: generate-managed-cluster-manifests
	kubectl --context kind-${MANAGING_CLUSTER_NAME} create ns ${MANAGED_CLUSTER_NAME} --dry-run=client -o yaml | kubectl apply -f -
	kubectl --context kind-${MANAGING_CLUSTER_NAME} apply -f ${MANAGED_CLUSTER_MANIFESTS_FILE} --dry-run=client -o yaml | kubectl apply -f -
	$(MAKE) managed-cluster-config managed-cluster-calico

managed-cluster-config:
	clusterctl --kubeconfig-context kind-${MANAGING_CLUSTER_NAME} get kubeconfig ${MANAGED_CLUSTER_NAME} -n ${MANAGED_CLUSTER_NAME} > ${MANAGED_CLUSTER_NAME}.kubeconfig

managed-cluster-calico:
	kubectl --kubeconfig=${MANAGED_CLUSTER_NAME}.kubeconfig apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml

# --- --- --- #

prepare-system:
	export SERVICE_CIDR=["10.96.0.0/12"]
	export POD_CIDR=["192.168.0.0/16"]
	export SERVICE_DOMAIN="k8s.test"
	sudo sysctl fs.inotify.max_user_watches=1048576
	sudo sysctl fs.inotify.max_user_instances=8192
	docker restart `docker ps -q`

install-calico:
	kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/calico.yaml

describe:
	clusterctl describe cluster ${MANAGED_CLUSTER_NAME} -n ${MANAGED_CLUSTER_NAME}
	kubectl get cluster -n ${MANAGED_CLUSTER_NAME}
	kubectl get kubeadmcontrolplane -n ${MANAGED_CLUSTER_NAME}
	kubectl --kubeconfig=${MANAGED_CLUSTER_NAME}.kubeconfig get nodes -n ${MANAGED_CLUSTER_NAME}

delete-managed-cluster:
	kubectl --context kind-${MANAGING_CLUSTER_NAME} delete -f ${MANAGED_CLUSTER_MANIFESTS_FILE} --ignore-not-found=true
	kubectl --context kind-${MANAGING_CLUSTER_NAME} delete ns ${MANAGED_CLUSTER_NAME}

delete-kind:
	kind delete cluster --name ${MANAGING_CLUSTER_NAME}
