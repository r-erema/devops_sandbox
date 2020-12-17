.PHONY: mk-start
mk-start:
	minikube start --driver=virtualbox --addons=ingress

.PHONY: mk-delete
mk-delete:
	minikube delete

.PHONY: install-kanban-postgres
install-kanban-postgres:
	helm install -f kanban-postgres.yaml postgres ./postgres

.PHONY: install-adminer
install-adminer:
	helm install -f adminer.yaml adminer ./app

.PHONY: install-kanban-app
install-kanban-app:
	helm install -f kanban-app.yaml kanban-app ./app

.PHONY: install-kanban-ui
install-kanban-ui:
	helm install -f kanban-ui.yaml kanban-ui ./app

.PHONY: dependency-update
dependency-update:
	helm dependency update ./ingress/

.PHONY: install-ingress
install-ingress:
	helm install -f ingress.yaml ingress ./ingress

.PHONY: full-restart
full-restart: \
	mk-delete \
	mk-start \
	install-kanban-postgres \
	install-adminer \
	install-kanban-app \
	install-kanban-ui \
	dependency-update \
	install-ingress
