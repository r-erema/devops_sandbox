.PHONY: mk-start
mk-start:
	minikube start --driver=virtualbox --addons=ingress

.PHONY: mk-delete
mk-delete:
	minikube delete

.PHONY: repos
repos:
	helmfile repos

.PHONY: sync
sync:
	helmfile sync

.PHONY: full-restart
full-restart: \
	mk-delete \
	mk-start \
	repos \
	sync
