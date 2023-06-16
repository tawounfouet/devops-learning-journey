


## Kubernetes : Initialisation et join du cluster

### Initialisation du cluster

```bash
sudo kubeadm init --apiserver-advertise-address=192.168.99.10 --node-name $HOSTNAME --pod-network-cidr=10.244.0.0/16 --token-ttl=0
```

kubeadm init --apiserver-advertise-address=192.168.99.10 --node-name $HOSTNAME --pod-network-cidr=10.244.0.0/16




sudo cp -i et /etc/kubernetes/admin.conf $HOME/.kube/config