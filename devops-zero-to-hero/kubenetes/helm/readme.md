## Mastering Helm V3

$ minikube start --memory=4098 --driver=hyperkit
$ minikube addons enable ingress
$ minikube addons enable metrics-server
$ minikube addons enable dashboard
$ minikube addons enable registry
$ minikube addons enable registry-creds
$ minikube addons enable registry-aliases
$ minikube addons enable storage-provisioner
$ minikube addons enable default-storageclass
$ minikube addons enable efk
$ minikube addons enable logviewer
$ 

### Helm is a package manager for Kubernetes
Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources. Helm is often referred to as the "Kubernetes package manager." 
Helm is a tool that streamlines installing and managing Kubernetes applications. Think of it like apt/yum/homebrew for Kubernetes. 


### Helm has two parts: a client (helm) and a server (tiller)
- Tiller runs inside of your Kubernetes cluster, and manages releases (installations) of your charts. 
- Helm runs on your laptop, CI/CD, or wherever you want it to run. 

### Helm 3 removes Tiller, Runs Helm locally
Helm 3 removes the Tiller requirement, and runs Helm client-side only. 

### Helm Charts are the package manager (analogous to yum or apt) of Kubernetes
Helm Charts are packages of pre-configured Kubernetes resources. Think of them like the Kubernetes equivalent of a Homebrew formula, an Apt dpkg, or a Yum RPM file.

### Helm Charts are easy to create, version, share, and publish
Helm Charts are written in a simple templating language, and are easily distributed via repositories (like Deis' Charts). There is even a chart repository (Helm Hub) for community-contributed Charts. You can also host your own Helm Chart repository.

### Helm Charts are useful for bundling up Kubernetes YAML files for deployment
Helm Charts are useful for bundling up Kubernetes YAML files for deployment. Helm Charts can be used to:
- Create reproducible builds of your Kubernetes applications
- Intelligently manage your Kubernetes manifest files
- Manage releases of Helm packages
- Share your applications as Helm Charts

### Helm Installation and Setup
- Download the latest release from the [releases page]
- Unpack it (tar -zxvf helm-v3.0.0-linux-amd64.tar.gz)
- Find the helm binary in the unpacked directory, and move it to its desired destination (mv linux-amd64/helm /usr/local/bin/helm)
- Add the helm repo (helm repo add stable https://kubernetes-charts.storage.googleapis.com/)
- Update the helm repo (helm repo update)
- Install the helm chart (helm install stable/mysql --generate-name)
- List the helm charts (helm list)
- Delete the helm chart (helm delete mysql-1577836528)

### Helm basic commands
$ helm version
$ helm create mychart
$ helm install mychart
$ helm list
$ helm delete mychart

### Helm advanced commands
$ helm install --name mychart mychart
$ helm install --name mychart --set service.type=NodePort mychart
$ helm install --name mychart --set service.type=NodePort --set service.nodePort=31000 mychart
$ helm install --name mychart --set service.type=NodePort --set service.nodePort=31000 --set image.tag=1.16.0 mychart
$ helm install --name mychart --set service.type=NodePort --set service.nodePort=31000 --set image.tag=1.16.0 --set image.pullPolicy=Always mychart
$ helm install --name mychart --set service.type=NodePort --set service.nodePort=31000 --set image.tag=1.16.0 --set image.pullPolicy=Always --set image.repository=nginx mychart

$ helm install --name mychart --set service.type=NodePort --set service.nodePort=31000 --set image.tag=1.16.0 --set image.pullPolicy=Always --set image.repository=nginx --set image.pullSecrets[0].name=myregistrykey mychart

$ helm install --name mychart --set service.type=NodePort --set service.nodePort=31000 --set image.tag=1.16.0 --set image.pullPolicy=Always --set image.repository=nginx --set image.pullSecrets[0].name=myregistrykey --set image.pullSecrets[0].key=myregistrykey mychart

$ helm install --name mychart --set service.type=NodePort --set service.nodePort=31000 --set image.tag=1.16.0 --set image.pullPolicy=Always --set image.repository=nginx --set image.pullSecrets[0].name=myregistrykey --set image.pullSecrets[0].key=myregistrykey --set image.pullSecrets[0].mountPath=/etc/docker/myregistrykey mychart



### Deploying a Helm Chart - Wordpress

#### Step 1: Create a namespace
$ kubectl create namespace wordpress
$ kubectl get namespaces
$ kubectl describe namespace wordpress
$ kubectl delete namespace wordpress

#### Step 2: Create a secret




### Déploiement Wordpress
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install wordpress bitnami/wordpress -f https://raw.githubusercontent.com/eazytrainingfr/kubernetes-training/master/tp-5/values.yml

#### Acces à l'application
$ kubectl get svc -n wordpress
$ kubectl get pods -n wordpress

$ echo Username: admin
$ echo Password: $(kubectl get secret --namespace default wordpress -o jsonpath="{.data.wordpress-password}" | base64 -d)
pwd : password% 


#### Lien utile
https://devopscube.com/install-configure-helm-kubernetes/


#### Installing Prometheus using Helm

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus
```


Expose prometheus-server service nodePort
```bash
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext
```

Expose prometheus-kube-state-metric service nodePort
```bash
kubectl expose service prometheus-kube-state-metrics --type=NodePort --target-port=8080 --name=prometheus-kube-state-metrics-ext
```

Get the PushGateway URL by running these commands in the same shell:
```bash
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus-pushgateway,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9091
```


#### Installing Grafana using Helm

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana
```

#### Login to Grafana
```bash
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```
password : d9jrLGCCqTMdT4hkSHwOm5SMChsIqFXaNL5NMaIW

1. Get your 'admin' user password by running:
```bash
   kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

2. The Grafana server can be accessed via port 80 on the following DNS name from within your cluster:
```bash
   grafana.default.svc.cluster.local

   Get the Grafana URL to visit by running these commands in the same shell:
     export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
     kubectl --namespace default port-forward $POD_NAME 3000
```

3. Create a NodePort mode grafane service
```bash
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext
```

Expose 

4. Get the Grafana URL to visit by running these commands in the same shell:
```bash
export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services grafana-ext)



#### Installing Spark using Helm
 ```bash 
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install spark bitnami/spark
    ```

1. Get the Spark master WebUI URL by running these commands:
```bash
  kubectl port-forward --namespace default svc/spark-master-svc 8085:80
  echo "Visit http://127.0.0.1:8085 to use your application"    
```
Expose spark-master-svc  service nodePort
```bash
kubectl expose service spark-master-svc --type=NodePort --target-port=7077 --name=spark-master-svc-ext
```
Delete spark-master-svc-ext service
```bash
kubectl delete service spark-master-svc-ext
```



### Déploiement Kubeflow
Kubeflow installation using alauda repository
```bash
helm repo add alauda https://alauda.github.io/charts/
helm repo update
helm install kubeflow alauda/kubeflow
```

```bash
helm install kubeflow alauda/kubeflow --namespace kubeflow --set jupyterhub.proxy.secretToken=$(openssl rand -hex 32)
```

```bash
wget -O values-cn.yaml https://raw.githubusercontent.com/alauda/kubeflow-chart/main/values-cn.yaml
helm install kubeflow alauda/kubeflow --namespace kubeflow --values values-cn.yaml
helm install kubeflow alauda/kubeflow -f values-cn.yaml
```

Instaling CRD (C) for Knative
```bash
kubectl apply -f https://github.com/knative/serving/releases/download/v0.26.1/serving-crds.yaml
```
