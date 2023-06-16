## Installation de Jenkins
``
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com/
$ helm repo update
$ helm install stable/jenkins --generate-name
$ helm list
$ helm delete jenkins-1577836528
``

Utiliser le repo bitnami pour installer Jenkins
```
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install jenkins bitnami/jenkins
$ helm list
$ helm delete jenkins-1577836528
```

Expose jenkins service nodePort
```bash
kubectl expose service jenkins --type=NodePort --target-port=8080 --name=jenkins-ext
```
kubectl expose service jenkins --type=NodePort --target-port=9050 --name=jenkins-ext
```


1. Get the Jenkins URL by running:
** Please ensure an external IP is associated to the jenkins service before proceeding **
** Watch the status using: 
$ kubectl get svc --namespace default -w jenkins **


```bash
export SERVICE_IP=$(kubectl get svc --namespace default jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo "Jenkins URL: http://$SERVICE_IP/"
```

2. Login with the following credentials
```bash
echo Username: user
echo Password: $(kubectl get secret --namespace default jenkins -o jsonpath="{.data.jenkins-password}" | base64 -d)
```
