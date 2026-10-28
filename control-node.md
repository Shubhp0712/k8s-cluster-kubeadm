# Kubernetes Cluster using Kubeadm
### Using Kubeadm we can configure Kubernetes control plan and connect worker nodes.

---
#### Before installing any runtime, you must configure your Linux nodes to allow bridged traffic and forward IPv4 packets
```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
```
#### Configure sysctl parameters (required for networking), sysctl params required by setup, params persist across reboots
```
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
```

#### Apply sysctl params without reboot
```
sudo sysctl --system
```

#### Install container runtime and Change the SystemCgroup parameter
```
sudo apt update
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```

#### Restart the containerd service and check status
```
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo systemctl status containerd
```

#### Install packages needed to use the Kubernetes apt repository
```
sudo apt-get update

sudo apt-get install -y ca-certificates curl gpg
```

#### Download the public signing key for the Kubernetes package repositories. The same signing key is used for all repositories so you can disregard the version in the URL
```
sudo mkdir -p -m 755 /etc/apt/keyrings

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.37/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

#### Add the appropriate Kubernetes 'apt' repository.
```
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.37/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

#### Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version
```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

#### (Optional) Enable the kubelet service before running kubeadm
```
sudo systemctl enable kubelet
```

#### Initialize Cluster with kubeadm
```
kubeadm init --pod-network-cidr=192.168.0.0/16
```
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

#### Worker Node Join url (Run on worker node)
```
kubeadm join 172.31.24.116:6443 --token c42csi.hb28b9ie2hrw6n68 \
        --discovery-token-ca-cert-hash sha256:5a618df741645693929819020188c66d9b85d7afea36f719a02ce49ef5feee33
```

#### Remove taint on Control node
```
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```

#### Install Network-Addon (Calico)
```
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.33.0/manifests/tigera-operator.yaml

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.33.0/manifests/custom-resources.yaml
```

#### Verification of Cluster node
```
kubectl get nodes
kubectl run nginx --image=nginx
kubectl get pods
```




