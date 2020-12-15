.PHONY: mk-start
mk-start:
	minikube start --driver=virtualbox --addons=ingress

.PHONY: mk-status
mk-status:
	minikube status

.PHONY: mk-delete
mk-delete:
	minikube delete

.PHONY: mk-ip
mk-ip:
	minikube ip

.PHONY: cluster-info
cluster-info:
	kubectl cluster-info

.PHONY: apply-adminer-deployment
apply-adminer-deployment:
	kubectl apply -f adminer-deployment.yaml

.PHONY: apply-adminer-service
apply-adminer-service:
	kubectl apply -f adminer-service.yaml

.PHONY: apply-ingress-controller
apply-ingress-controller:
	kubectl apply -f ingress-controller.yaml

.PHONY: apply-postgres-volume
apply-postgres-volume:
	kubectl apply -f postgres-volume.yaml

.PHONY: apply-postgres-config
apply-postgres-config:
	kubectl apply -f postgres-config.yaml

.PHONY: apply-postgres-deployment
apply-postgres-deployment:
	kubectl apply -f postgres-deployment.yaml

.PHONY: apply-postgres-service
apply-postgres-service:
	kubectl apply -f postgres-service.yaml

.PHONY: kanban-app-deployment
kanban-app-deployment:
	kubectl apply -f kanban-app-deployment.yaml

.PHONY: kanban-app-service
kanban-app-service:
	kubectl apply -f kanban-app-service.yaml

.PHONY: kanban-ui-deployment
kanban-ui-deployment:
	kubectl apply -f kanban-ui-deployment.yaml

.PHONY: kanban-ui-service
kanban-ui-service:
	kubectl apply -f kanban-ui-service.yaml

.PHONY: enable-ingress
enable-ingress:
	minikube addons enable ingress

.PHONY: deployments
deployments:
	kubectl get deployments

.PHONY: pods
pods:
	kubectl get pods

.PHONY: services
services:
	kubectl get services

sleep:
	echo Sleep a little...
	sleep 30

.PHONY: full-restart
full-restart: \
	mk-delete \
	mk-start \
	apply-adminer-deployment \
	apply-adminer-service \
	enable-ingress \
	sleep \
	apply-ingress-controller \
	apply-postgres-volume \
	apply-postgres-config \
	apply-postgres-deployment \
	apply-postgres-service \
	kanban-app-deployment \
	kanban-app-service \
	kanban-ui-deployment \
	kanban-ui-service
