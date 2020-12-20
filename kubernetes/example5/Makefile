.PHONY: get-spray
get-spray:
	git clone git@github.com:kubernetes-sigs/kubespray.git \
	cd kubspray

.PHONY: pip3
pip3:
	sudo apt install python3-pip -y
	sudo pip3 install -r requirements.txt

.PHONY: mount
mount:
	mkdir -p /mnt/disks/vdb1
	mount /dev/vdb1 /mnt/disks/vdb1

.PHONY: apply
apply:
	ansible-playbook \
    	-i ./inventory/roombot-cluster/hosts.yaml \
    	./cluster.yml \
    	--become \
    	--become-user=root \
    	--extra-vars 'ansible_sudo_pass=1qaz!QAZ' \
    	-e dashboard_enabled=True \
    	-e helm_enabled=True \
    	-e local_volume_provisioner_enabled=True \
    	-e local_volume_provisioner_enabled.local_volume_provisioner_storage_classes.local-storage.host_dir=/kubernetes-data \
    	-e local_volume_provisioner_enabled.local_volume_provisioner_storage_classes.local-storage.mount_dir=/kubernetes-data \
    	--ask-pass


apply-ext:
	apply:
		ansible-playbook \
			-i ./inventory/roombot-cluster/hosts.yaml \
			./cluster.yml \
			--become \
			--become-user=root \
			--extra-vars ansible_sudo_pass='1qaz!QAZ' \
			-e dashboard_enabled=True \
			-e helm_enabled=True \
			-e local_volume_provisioner_enabled=True \
			-e local_volumes_enabled=True \
			-e local_volume_provisioner_base_dir=/kubernetes-data \
			-e local_volume_provisioner_mount_dir=/kubernetes-data \
			-e local_volume_provisioner_storage_class=local-storage

.PHONY: docker-user
docker-user:
	sudo usermod -aG docker ${USER}

reset:ss
	ansible-playbook \
		-i -i ./hosts.yml \
		kubespray/reset.yml \
		--become \
		--become-user=root \
		--extra-vars "ansible_sudo_pass=${PASS}"

.PHONY: copy-conf
copy-conf:
	sudo cp /etc/kubernetes/admin.conf ~/.kube/config

.PHONY: proxy
proxy:
	kubectl proxy --address=0.0.0.0 --accept-hosts=".*" &

.PHONY: dashboard-skip-login
dashboard-skip-login:
	KUBE_EDITOR="nano" kubectl edit deployment kubernetes-dashboard
	# --enable-skip-login

.PHONY: run
run: apply


