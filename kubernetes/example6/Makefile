run-cluster:
	minikube start

ctx:
	kubectl config get-contexts

ctx-minikube:
	kubectl config use-context minikube

ns-yaml:
	kubectl create namespace production --dry-run=client -o yaml > ns_temp.yaml
apply-ns:
	kubectl apply -f ns.yaml

pod-yaml:
	kubectl run nginx-prod --image=nginx --dry-run=client --namespace production -o yaml > pod_temp.yaml
apply-pod:
	kubectl apply -f pod.yaml

cron-job-yaml:
	kubectl create cronjob sleepy \
		--schedule="*/2 * * * *" \
		--image=alpine \
		--namespace production \
		--dry-run=client -o yaml > cron_job_temp.yaml
apply-cron-job:
	kubectl apply -f cron_job.yaml

deployment-yaml:
	kubectl create deployment nginx --replicas=5 --image=nginx:1.9 --dry-run=client --namespace production -o yaml > deployment_temp.yaml
apply-deployment:
	kubectl apply -f deployment.yaml

service-yaml:
	kubectl expose deployment nginx --port 80 --dry-run=client --namespace production -o yaml > service_temp.yaml
apply-service:
	kubectl apply -f service.yaml

node-port-yaml:
	kubectl expose deployment nginx --port 80 --type=NodePort --dry-run=client --namespace production -o yaml > node_port_temp.yaml
apply-node-port:
	kubectl apply -f node_port.yaml

apply-ingress:
	kubectl apply -f ingress.yaml

apply-pv:
	kubectl apply -f pv.yaml

apply-pvc:
	kubectl apply -f pvc.yaml

deployment2-yaml:
	kubectl create deployment nginx2 --replicas=1 --image=nginx:1.9 --dry-run=client --namespace production -o yaml > deployment_temp.yaml
create-secret:
	kubectl create secret generic my-secret \
		--from-file=ssh-privatekey=./data/id_rsa \
		--from-literal=username=anna --from-literal=password=secret \
		--namespace production
describe-secret:
	kubectl describe secrets my-secret --namespace production
get-secret:
	kubectl get secrets my-secret -o yaml --namespace production
apply-deployment2:
	kubectl apply -f deployment2.yaml --namespace production

apply-pod-with-sidecar:
	kubectl apply -f pod_with_sidecar.yaml

reset:
	kubectl delete all --all
	kubectl delete all --all -n production
	kubectl delete secret my-secret --namespace production

run: apply-ns \
	 apply-pv \
	 apply-pvc \
     apply-pod \
     apply-cron-job \
     apply-deployment \
     apply-deployment \
     apply-service \
     apply-ingress \
     create-secret \
     apply-deployment2 \
     apply-pod-with-sidecar

refresh: reset run
