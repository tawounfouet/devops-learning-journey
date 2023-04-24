# Installation de minikube [code utilisé]

ATTENTION : Le code est utilisé pour une VM centos7 (sur un autre OS il faudra vous référez à la documentation officielle)

Utilisez une VM de minimum 4 Go et 2 CPU, les commandes suivantes ont été testées sur centos7 et les commandes ont été exécutées avec le user centos qui a les droits admin

sudo yum -y update

sudo yum -y install epel-release

sudo yum -y install git libvirt qemu-kvm virt-install virt-top libguestfs-tools bridge-utils

sudo yum install socat -y

sudo yum install -y conntrack

sudo curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

sudo usermod -aG docker centos

suudo systemctl start docker

sudo yum -y install wget

sudo wget https://storage.googleapis.com/minikube/releases/v1.11.0/minikube-linux-amd64

sudo chmod +x minikube-linux-amd64

sudo mv minikube-linux-amd64 /usr/bin/minikube

sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.0/bin/linux/amd64/kubectl

sudo chmod +x kubectl

sudo mv kubectl /usr/bin/

sudo echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

sudo systemctl enable docker.service

minikube start --driver=none --kubernetes-version v1.23.0

Pour l'autocomplétion:

echo 'source <(kubectl completion bash)' >> ${HOME}/.bashrc && source ${HOME}/.bashrc

### Vagranfile centos7 config
'''bash
RAM = 4096
CPU = 2

Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/centos7"
  config.vm.network "private_network", type: "static", ip: "192.168.130.10"
  config.vm.provider "virtualbox" do |v|
  config.vm.hostname = "kubernetes"
    v.memory = RAM
    v.cpus = CPU
  end
end
'''