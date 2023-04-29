## Ingress  

Ressouces uties:
- https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/ 
- https://kubernetes.github.io/ingress-nginx/deploy/#provider-specific-steps
- https://kubernetes.io/docs/concepts/services-networking/ingress/
  
Labs de référence:
- https://killercoda.com/playgrounds/scenario/kubernetes
- https://labs.play-with-k8s.com/p/ch6lcev9gifg0099o5hghttps://labs.play-with-k8s.com/p/ch6lcev9gifg0099o5hg
  


### Installation de l'addon ingress
1. To enable the NGINX Ingress controller, run the following command:
``` bash
minikube addons enable ingress
```
2. Verify that the NGINX Ingress controller is running:
``` bash
kubectl get pods -n kube-system
kubectl get pods -n ingress-nginx
```



### Deployer une application avec un ingress - Hello World App

#### Deployer l'application hello world:
1. Create a deployment for the hello world app:
``` bash    
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0

```
2. Expose the deployment:
``` bash
kubectl expose deployment web --type=NodePort --port=8080
kubectl get pods
kubectl get deploy
kubectl get service web
```
- visit the webapp via url (pour avoir l'ip de mon service):
``` bash
minikube service web
```
output: http://192.168.64.2:30450


3. Create an ingress resource:
``` bash    
kubectl apply -f https://kubernetes.github.io/ingress-nginx/deploy/static/provider/cloud/deploy.yaml
```

#### Creation de la règle d'ingress (ingress rule):

1. Create example-ingress.yaml from the following file:
   
``` yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
    rules:
    - host: hello-world.info
        http:
        paths:
        - path: /
            pathType: Prefix
            backend:
            service:
                name: web
                port:
                number: 8080
```
``` bash
kubectl apply -f example-ingress.yml
kubectl get ingress
kubectl describe ingress example-ingress
```
NAME              CLASS    HOSTS             ADDRESS   PORTS   AGE
example-ingress   <none>   hello-world.info             80      2m


Get ingress kubectl command with adress ip
``` bash
kubectl get ingress -o wide
kubectl get ingress -o yaml
```
NAME              CLASS   HOSTS              ADDRESS        PORTS   AGE
example-ingress   nginx   hello-world.info   192.168.64.2   80      3m23s

#####  Modifier notre fichier host pour ajouter l'adresse ip de notre ingress controller
``` bash    
sudo vi /etc/hosts
```
Ajouter la ligne suivante:
``` bash
192.168.64.2 hello-world.info
```


#### Create a second Deployment 
1. Create another Deployment using the following command:
``` bash
kubectl create deployment web2 --image=gcr.io/google-samples/hello-app:2.0
```
The output should be:
deployment.apps/web2 created

2. Expose the second Deployment:
``` bash
kubectl expose deployment web2 --port=8080 --type=NodePort
```
The output should be:
service/web2 exposed



#### Edit the existing Ingress
Edit the existing example-ingress.yaml manifest, and add the following lines at the end:
``` yaml
- path: /v2
  pathType: Prefix
  backend:
    service:
      name: web2
      port:
        number: 8080
```
Apply the changes:
```bash
kubectl apply -f example-ingress-edit.yml
```
You should see:
ingress.networking/example-ingress configured

#### Test your Ingress
$ curl hello-world.info/v2
$ curl hello-world.info


#### Test your Ingress
Access the 1st version of the Hello World app.
``` bash
curl --resolve "hello-world.info:80:$( minikube ip )" -i http://hello-world.info
```
The output is similar to:
Hello, world!
Version: 1.0.0
Hostname: web-55b8c6998d-8k564

Access the 2nd version of the Hello World app.
``` bash
curl --resolve "hello-world.info:80:$( minikube ip )" -i http://hello-world.info/v2
```
The output is similar to:
Hello, world!
Version: 2.0.0
Hostname: web2-75cd47646f-t8cjk
``` bash
kubectl get svc 
kubectl get svc -o wide
```



1. Create the ingress resource:
   
       
2. Verify that the ingress resource was created:
``` bash
kubectl get ingress
```
1. Get the IP address of the ingress controller:
``` bash
kubectl get service -l app.kubernetes.io/name=ingress-nginx --namespace ingress-nginx
```
1. Open a browser and enter the IP address of the ingress controller. You should see the hello world app:
``` bash
http://<IP address of the ingress controller>
```
1. Clean up:
``` bash
kubectl delete ingress web
kubectl delete service web
kubectl delete deployment web
```
1. Verify that the ingress resource was deleted:
``` bash
kubectl get ingress
```
1.  Verify that the hello world app is no longer available:
``` bash
http://<IP address of the ingress controller>
```

Les règles ingress ont là pour nous aider à définir quel traffic doit être routé vers quel service. (quel traffic ira ou)
Les règles ingress sont là pour nous permettre de faire du routage de trafic vers nos services.


### Résumé de ce qui a été fait:
Dans cette partie nous avons vu comment déployer une application hello world, comment exposer cette application via un service, comment créer une règle ingress pour pouvoir accéder à notre application via un nom de domaine et comment faire du routage de trafic vers nos services.
- Création d'un deployment
- Création d'un service
- Création d'une règle ingress
- Création d'un fichier host pour pouvoir accéder à notre application via un nom de domaine 
- Création d'une règle ingress pour faire du routage de trafic vers nos services
