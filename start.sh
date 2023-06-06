#!/bin/bash
ansible-playbook hostsetup.yml
sleep 3
ansible-playbook setup.yml
sleep 3
ansible-playbook setchrony.yml
sleep 3
ansible-playbook nodedisk.yml
sleep 3
ansible-playbook set_containerd_and_nerdctl.yml
sleep 3
ansible-playbook setLoadBalancing.yml
sleep 3
ansible-playbook InitializeK8S.yml
sleep 3
ansible-playbook add_master_and_node.yml
sleep 3
ansible-playbook final_setup_and_cleanup.yml
sleep 3
if [ ! -d ~/.kube ] ; then
	mkdir -p /root/.kube && sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config && sudo chown $(id -u):$(id -g) /root/.kube/config
fi
kubectl apply -f kube-flannel.yml
source /etc/profile.d/kubernetes.sh
