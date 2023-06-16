

Surcharge de la configuration par défaut avec un job supplémentaire - configmap

```yaml
      - job_name: 'kubernetes-apiservers'
        kubernetes_sd_configs:
        - role: endpoints
        scheme: https
        tls_config:
          ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
        relabel_configs:
        - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
          action: keep
          regex: default;kubernetes;https
```
Suppression du configmap et deployment
```bash
kubectl delete configmaps prometheus-server -n monitoring
kubectl delete deployment prometheus-server -n monitoring
```

Recréation du configmap et deployment
```bash
kubectl create -f config-map.yaml -n monitoring
kubectl apply -f prometheus-deployment.yaml -n monitoring
```