set-pass:
	htpasswd -Bbn admin 123 > ./htpasswd

gen-hash:
	echo -n "admin:123" | base64

push:
	docker pull docker:19.03.1 && \
    docker tag docker:19.03.1 localhost:8123/docker:19.03.1 && \
	echo dAj4w@7fl | docker login localhost:8123 --username admin --password-stdin && \
    docker push localhost:8123/docker:19.03.1

push-go:
	docker pull golang:1.15 && \
    docker tag golang:1.15 localhost:8123/golang:1.15 && \
	echo {%PASS%} | docker login localhost:8123 --username admin --password-stdin && \
    docker push localhost:8123/golang:1.15

linter:
	gitlab-runner exec docker linter

docker-prod:
	gitlab-runner exec docker \
		--env DOCKER_AUTH_CONFIG='{ "auths": { "localhost:8123": { "auth": "YWRtaW46ZEFqNHdAN2Zs" } } }' \
		--env CI_REGISTRY_PASSWORD=123 \
		--env CI_REGISTRY=localhost:8123 \
		--env REACT_APP_API_BASE_URL=https://mroom.itechart-group.com \
		--docker-extra-hosts localhost:192.168.1.2 \
		--docker-volumes="/var/run/docker.sock:/var/run/docker.sock" \
		docker

vm-deploy-prod:
	gitlab-runner exec docker \
		--env DOCKER_AUTH_CONFIG="{\"auths\":{\"localhost:8123\":{\"auth\":\"YWRtaW46MTIz\"}}}" \
		--env CI_REGISTRY_PASSWORD=123 \
		--env CI_REGISTRY=localhost:8123 \
		--env PORT=3001 \
		--docker-extra-hosts localhost:192.168.1.2 \
		--docker-volumes="/var/run/docker.sock:/var/run/docker.sock" \
		vm-deploy

docker-test:
	gitlab-runner exec docker \
		--env DOCKER_AUTH_CONFIG="{\"auths\":{\"localhost:8123\":{\"auth\":\"YWRtaW46MTIz\"}}}" \
		--env CI_REGISTRY_PASSWORD=123 \
		--env CI_REGISTRY=localhost:8123 \
		--env TEST_REACT_APP_API_BASE_URL=http://192.168.25.58:8447 \
		--docker-extra-hosts localhost:192.168.1.2 \
		--docker-volumes="/var/run/docker.sock:/var/run/docker.sock" \
		docker-test

vm-deploy-test:
	gitlab-runner exec docker \
		--env DOCKER_AUTH_CONFIG="{\"auths\":{\"localhost:8123\":{\"auth\":\"YWRtaW46MTIz\"}}}" \
		--env CI_REGISTRY_PASSWORD=123 \
		--env CI_REGISTRY=localhost:8123 \
		--env TEST_PORT=3002 \
		--docker-extra-hosts localhost:192.168.1.2 \
		--docker-volumes="/var/run/docker.sock:/var/run/docker.sock" \
		vm-deploy-test

docker-qa:
	gitlab-runner exec docker \
		--env DOCKER_AUTH_CONFIG="{\"auths\":{\"localhost:8123\":{\"auth\":\"YWRtaW46MTIz\"}}}" \
		--env CI_REGISTRY_PASSWORD=123 \
		--env CI_REGISTRY=localhost:8123 \
		--env QA_REACT_APP_API_BASE_URL=http://192.168.25.58:8337 \
		--docker-extra-hosts localhost:192.168.1.2 \
		--docker-volumes="/var/run/docker.sock:/var/run/docker.sock" \
		docker-qa

vm-deploy-qa:
	gitlab-runner exec docker \
		--env DOCKER_AUTH_CONFIG="{\"auths\":{\"localhost:8123\":{\"auth\":\"YWRtaW46MTIz\"}}}" \
		--env CI_REGISTRY_PASSWORD=123 \
		--env CI_REGISTRY=localhost:8123 \
		--env QA_PORT=3003 \
		--docker-extra-hosts localhost:192.168.1.2 \
		--docker-volumes="/var/run/docker.sock:/var/run/docker.sock" \
		vm-deploy-qa

all: linter \
	 docker-test \
	 vm-deploy-test \
	 docker-qa \
	 vm-deploy-qa \
	 docker-prod \
	 vm-deploy-prod
