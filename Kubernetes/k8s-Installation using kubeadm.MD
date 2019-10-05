# Kubernetes Installation using Kubeadm

## Installing kubeadm

### Prerequisites

- One or more machines running one of:
    - Ubuntu 16.04+
    - Debian 9+
    - CentOS 7
    - Red Hat Enterprise Linux (RHEL) 7

- 2 GB or more of RAM per machine (any less will leave little room for your apps)
- 2 CPUs or more
- Full network connectivity between all machines in the cluster (public or private network is fine)

## Install Docker on all the Nodes

Note: before installing docker version, check the compatable docker version in the kubernetes documentation 

[DockerofficialDoc](https://docs.docker.com/install/linux/docker-ce/centos/)
```sh
 - yum install -y yum-utils   device-mapper-persistent-data  lvm2

 - yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

 - yum list docker-ce --showduplicates | sort -r

 - yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io

 - yum install docker-ce-18.09.9 docker-ce-cli-18.09.9 containerd.io

- systemctl start docker

- systemctl enable docker
```
### Install Kubeadm Kubelet kyubectl On all Nodes 

Configuring Kubernetes cluster with kubeadm:

[official Kubernetes Documentation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

## Configure Repository fopr Kubeadm 
```sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Set SELinux in permissive mode (effectively disabling it)
setenforce 0

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable --now kubelet

Some users on RHEL/CentOS 7 have reported issues with traffic being routed incorrectly due to iptables being bypassed. You should ensure net.bridge.bridge-nf-call-iptables is set to 1 in your sysctl config, e.g

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system
```

#  Using kubeadm to Create a Cluster

Installing kubeadm on your hosts:(Master)
## Initializing your control-plane node
```sh
kubeadm init --pod-network-cidr=10.244.0.0/16

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You can now join any number of machines by running the following on each node
as root:

  kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>

```

**Note: Copy the Join Token and run on all the nodes**

## Installing a pod network add-on
```sh
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
```

kubectl cluster-info

kubectl get pods -n kube-system

kubectl get nodes
