### Installation NodeExporter avec helm

#### Definition du NodeExporter

Un exporter est un programme qui exporte les métriques de la machine hôte. Ces métriques sont ensuite récupérées par Prometheus. Dans notre cas, nous allons utiliser NodeExporter qui est un exporter pour les machines Linux.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install node-exporter prometheus-community/prometheus-node-exporter
helm install node-exporter prometheus-community/prometheus-node-exporter -f config-map.yaml -f prometheus-deployment.yaml -n monitoring
```



$ hlem search repo prometheus-community
$ 

1. Get the application URL by running these commands:
```bash
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=prometheus-node-exporter,app.kubernetes.io/instance=node-exporter" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:9100 to use your application"
  kubectl port-forward --namespace default $POD_NAME 9100
```


Surcharge de la configuration par défaut avec un job supplémentaire - configmap

```yaml
      - job-name:'node-exporter'
        static_configs:
          - targets: ['node-exporter-prometheus-node-exporter.default.svc:9100']
```
Suppression du configmap et deployment
```bash
kubectl delete configmaps prometheus-server -n monitoring
kubectl delete deployment prometheus-server -n monitoring
```

Recréation du configmap et deployment
```bash
kubectl apply -f config-map.yaml -n monitoring
kubectl apply -f prometheus-deployment.yaml -n monitoring
```

Expose prometheus-server service nodePort
```bash
kubectl expose service prometheus-server -n monitoring --type=NodePort --target-port=9095 --name=prometheus-server-ext
```

kubectl delete deployment prometheus-deployment -n monitoring
kubectl delete svc prometheus-server  -n monitoring
kubectl delete svc prometheus-server-ext -n monitoring
kubectl delete namespace monitoring

```bash
kubectl create namespace monitoring
helm install node-exporter prometheus-community/prometheus-node-exporter -f config-map.yaml -f prometheus-deployment.yaml -n monitoring
```
```bash
kubectl expose service prometheus-server -n monitoring --type=NodePort --target-port=9100 --name=prometheus-prometheus-node-exporter-ext
```

```bash