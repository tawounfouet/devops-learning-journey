

## Kubernetes State Metrics

### Installation

```bash
clone https://github.com/kubernetes/kube-state-metrics.git
cd kube-state-metrics/examples/standard
kubectl apply -f .
```

$  kubectl get svc -n kube-system   


Surcharge de la configuration par défaut avec un job supplémentaire - configmap
$

```yaml
- job_name: 'kube-state-metrics'
        static_configs:
          - targets: ['kube-state-metrics.kube-system.svc:8080']
```



```
Suppression du configmap et deployment
```bash
kubectl delete configmaps prometheus-server-conf  -n monitoring
kubectl delete deployment prometheus-server -n monitoring
```

Recréation du configmap et deployment
```bash
kubectl create -f config-map.yaml -n monitoring
kubectl apply -f prometheus-deployment.yaml -n monitoring