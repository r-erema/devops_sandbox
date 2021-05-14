.PHONY: force-remove-namespace
force-remove-namespace:
	kubectl get namespace ${NAMESPACE} -o json > ${NAMESPACE}.json
	sed -i -e '/"kubernetes"/d' ${NAMESPACE}.json
	kubectl replace --raw "/api/v1/namespaces/${NAMESPACE}/finalize" -f ./${NAMESPACE}.json
	kubectl delete ns ${NAMESPACE}
	rm ${NAMESPACE}.json
