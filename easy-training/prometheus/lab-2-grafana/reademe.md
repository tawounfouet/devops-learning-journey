## Grafana installation 


### 1. Install Grafana

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana
```

Surcharger les valeurs par défaut du chart helm grafana

```bash
helm install grafana grafana/grafana -f values.yml
```
surchager l'installation de Graphana dashboard 
    
```bash
helm install grafana-dasboard grafana/grafana -f values.yaml --version 3.12.1
```


1. Get your 'admin' user password by running:

```bash
kubectl get secret --namespace default grafana-dasboard -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```
pwd : dFlmGIRBd1rp6AkTBm1u8tSoj52p6O6rWZFYWr8d


2. The Grafana server can be accessed via port 9000 on the following DNS name from within your cluster:
```bash
grafana-dasboard.default.svc.cluster.local

Get the Grafana URL to visit by running these commands in the same shell:
    export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services grafana-dasboard)
    export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
    echo http://$NODE_IP:$NODE_PORT
```
url : http://192.168.64.9:30007