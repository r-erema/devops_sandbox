# 1. Create namespace ckad-ns1, run the following pods \
	* with name: pod-a, image: httpd \
	* with name: pod-b, images: nginx, alpine
1-create-namespace:
	kubectl create namespace ckad-ns1
1-pods-yaml:
	kubectl run pod-a --image httpd -n ckad-ns1 --dry-run=client -o yaml > 1.yaml
	echo "\n---" >> 1.yaml
	# Add nginx container manually
	kubectl run pod-b --image nginx --image alpine -n ckad-ns1 --dry-run=client -o yaml >> 1.yaml
1-apply:
	kubectl apply -f 1.yaml
1-reset:
	kubectl delete -f 1.yaml

# 2. Which command would you use to find Deployments that have the label 'app' set to 'nginx'
2-create-deployment:
	kubectl create deployment nginx --image nginx  -o yaml
2-find-deployment:
	kubectl get all --selector='app=nginx' -o wide
2-reset:
	kubectl delete deployment nginx

# 3. In the ckad-ns2 namespace, run a pod 'alpine-pod'. This Pod should run a continer based on the alpine image. \
In this container 2 variables must be set: \
 - 'localport' is set to 'localhost:8082' \
 - 'external_url' is set to 'linux.com'
3-create-namespace:
	kubectl create namespace ckad-ns2
3-yaml:
	kubectl run alpine-pod --image=alpine -n ckad-ns2 --dry-run=client -o yaml >> 3.yaml
	echo "\n---" >> 3.yaml
	kubectl create configmap 3-configmap \
		--from-literal "localport=localhost:8082" \
		--from-literal "external_url=linux.com" \
		-n ckad-ns2 \
		--dry-run=client -o yaml >> 3.yaml
3-apply:
	kubectl apply -f 3.yaml
3-reset:
	kubectl delete -f 3.yaml

# 4. Create a multi-container pod with the name sidecar-pod, that runs in the ckad-ns3 namespace \
 - the primary container is running Busybox, and writes the output of the date command to the /var/log/date.log file every 5 seconds \
 - the 2 conatainer should run as a sidecar and provide access to this file, using hostPath shared volume \
 - make sure the image for this container is only pulled if it's not available on the local system yet.
4-create-namespace:
	kubectl create namespace ckad-ns3
4-yaml:
	kubectl run sidecar-pod -n ckad-ns3 --image=busybox --dry-run=client -o yaml >> 4.yaml
4-apply:
	kubectl apply -f 4.yaml
4-reset:
	kubectl delete -f 4.yaml

# 5. The Pod my-server is running 3 containers: file-server, log-server and db-server. When starting it, the log-server fails. \
Which command should you use to analyze why it is going wrong?
5-pods-yaml:
	kubectl run my-server --image httpd --dry-run=client -o yaml > 5.yaml
5-apply:
	kubectl apply -f 5.yaml
5-reset:
	kubectl delete -f 5.yaml
5-describe:
	kubectl describe pod my-server
	kubectl logs my-server log-server


# 6. Create a Pod that runs the httpd webserver \
 * the webserver should be offering its services on port 80, and run in the ckad-ns3 namespaces\
 * this Pod should use a readiness probe with an initial delay of 60 seconds \
 * the probe should check the availability of the webserver document root (path /), before start and during operation as well
6-pods-yaml:
	kubectl run webserver --image httpd -n ckad-ns3 --dry-run=client -o yaml > 6.yaml
6-apply:
	kubectl apply -f 6.yaml
6-reset:
	kubectl delete -f 6.yaml

# 7. Creating a Deployment \
Write a manifest file with the name nginx-exam.yaml, that meets the following requirements \
 * it starts 5 replicas that run the nginx:1.8 image \
 * each Pod has the label app=webshop \
 * create the Deployment such that the existing Pods are terminated before new Pods are created to replace them \
 * the Deployment itself should use the label service=nginx
7-deployment-yaml:
	kubectl create deployment nginx --image nginx:1.8 --dry-run=client -o yaml > nginx-exam.yaml
7-apply:
	kubectl apply -f nginx-exam.yaml
7-reset:
	kubectl delete -f nginx-exam.yaml

# 8. Exposing services \
In the ckad-ns6 NameSpace, create a Deployment that runs the nginx:1.8 image and give it the name nginx-deployment \
 * ensure it runs 3 replicas \
 * after verifying that the Deployment runs successfully, expose it such that users are external to the cluster can reach it, \
   using the K8S Service object
8-yaml:
	kubectl create ns ckad-ns6 --dry-run=client -o yaml > 8.yaml
	echo "\n---" >> 8.yaml
	kubectl create deployment nginx-deployment -n ckad-ns6 --image nginx:1.8 --dry-run=client -o yaml >> 8.yaml
8-expose-yaml:
	echo "\n---" >> 8.yaml
	kubectl expose deployment nginx-deployment --type NodePort --port 80 -n ckad-ns6 --dry-run=client -o yaml >> 8.yaml
8-apply:
	kubectl apply -f 8.yaml
8-reset:
	kubectl delete -f 8.yaml

# 9. Using Network Policies \
Create a YAML file with the name my-nm-policy that runs 2 pods and a network policy \
 * The Pod may be dummies and don't really have to provide specific \
   functionality, as long as they will be running for at least 3600 seconds \
 * One pod simulates running a database, the other pod simulates running a webserver \
 * Use a network policy to restrict traffic between pods in the following way: \
    * Incoming and outgoing traffic to the webserver is allowed without any restrictions \
    * Only the webserver is allowed to access the database \
    * No outgoing traffic is allowed from the database pod
9-yaml:
	kubectl run webserver --image httpd  --dry-run=client -o yaml > 9.yaml
	echo "\n---" >> 9.yaml
	kubectl run database --image busybox --dry-run=client -o yaml >> 9.yaml
9-apply:
	kubectl apply -f 9.yaml
9-reset:
	kubectl delete -f 9.yaml

# 10. Using Storage \
  All objects should be created ckad-1312 namespce \
  * Create PV wuth the name 1312-pv, it should provide 2GB, r/w access to multiple clients simultaniuosly. Use any storage type you like. \
  * Create PVC that requests 1GB from any PV that allows multiple clients simultaneous r/w access. The name of the object should be 1312-pvc. \
  * Finally, create a Pod with the name 1312-pod that uses this PV. It should run an Nginx image, and mount the volume on the directory /webdata.
10-apply:
	kubectl apply -f 10.yaml
10-describe:
	kubectl describe pod database -n ckad-1312
10-reset:
	kubectl delete -f 10.yaml
