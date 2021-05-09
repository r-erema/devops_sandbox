.PHONY: run
prometheus:
	docker run \
		-p 9090:9090 \
		-v ${PWD}/config:/etc/prometheus \
		prom/prometheus

grafana:
	docker run -d -p 3000:3000 --name grafana grafana/grafana:latest

.PHONY: app
app:
	docker run -v ${PWD}/app:/app -w /app -p 9091:9091 node:16.1.0-slim node index.js

node-exporter:
	./node_exporter --path.procfs /host/proc --path.sysfs /host/sys --collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
