## Prometheus Deployment

1. Create a namespace dedicated to Prometheus - Monitoring
```bash
kubectl create namespace monitoring
kubectl apply -f clusterRole.yaml
kubectl apply -f config-map.yaml
kubectl apply -f prometheus-deployment.yaml -n monitoring
kubectl apply -f prometheus-service.yaml -n monitoring
```

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus
```

surcharge des valeurs par défaut du chart helm prometheus avec config.yaml
```bash
helm install prometheus prometheus-community/prometheus -f config-map.yaml -f clusterRole.yaml -f alertmanager-deployment.yaml -f alertmanager-service.yaml -n monitoring

helm install prometheus prometheus-community/prometheus -f config-map.yaml -f clusterRole.yaml -f alertmanager-deployment.yaml -f alertmanager-service.yaml -f prometheus-deployment.yaml  -f prometheus-service.yaml -n monitoring

helm install prometheus prometheus-community/prometheus -f config-map.yaml -f clusterRole.yaml -n monitoring
```

```
helm install prometheus prometheus-community/prometheus -f values.yaml
```

Expose prometheus-server service nodePort
```bash
kubectl expose service prometheus-server -n monitoring --type=NodePort --target-port=9090 --name=prometheus-server-ext
```

delete service with namespace monitoring
```bash
kubectl delete svc prometheus-service -n monitoring
```

delete namespace monitoring
```bash
kubectl delete namespace monitoring
```


Install CRD
```bash
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml 
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml
```


$ kubectl get crd | grep monitoring.coreos.com
$ kubectl get namespaces


Nb config.yaml
```yaml
scrape configs:
    -  job_name : 'prometheus'
       scrape_interval: 5s
       static_configs:
       - targets: ['prometheus-service.monitoring.svc.cluster.local:8090']
```

Port forward
```bash
kubectl port-forward --address 0.0.0.0  svc/prometheus-service 8090:8090 -n monitoring
```

```
kubectl port-forward -n monitoring prometheus-prometheus-0 9090
```

delele service
```bash
kubectl delete svc prometheus-service -n monitoring
```
kubectl delete svc prometheus-service 