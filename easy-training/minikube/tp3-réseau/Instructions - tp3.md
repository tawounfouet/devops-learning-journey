## Créer un service de type NodePort

- Ecrivez un manifest namespace.yml qui crée un namespace nommé production et la lancez ce naemspace à partir du manifest
- Toutes les ressources que vous allez créer dans la suite de l'exercice doivent être créées dans le namespace production
- Ecrivez un manifest pod-red pour déploier un pod nommé pod-red avec l'image mmumshad/simple-webapp-color en précisant que la couleur souhaitée est red, le pod doit posseder le label "app:web"
- Ecrivez un manifest pod-blue pour déploier un pod nommé pod-blue avec l'image mmumshad/simple-webapp-color en précisant que la couleur souhaitée est blue, le pod doit posseder le label "app:web"
- Lancez la création les deux pods à partir des manifests
- Ecrivez un manfinest service-nodeport-web.yml qui permettra d'exposer les pods via un service de type node port, le NodePort devra être le 30080 et les targets, les ports 8080 de nos pods dont le label est "app:web".
- Lancez la création du service à partir du manifest et vérifiez qu'il trouve bien les deux pods (champ endpoint en utilisant la commande kubectl describe svc web -n production)
- Vérifier que l'application est bien disponible en ouvrant le port 30080 de minikube dans votre noeud hôte
- Créer un répertoire tp3 dans votre repository git et y ajouter les manifests namespace.yml, pod-red.yml, pod-blue.yml et service-nodeport-web.yml
- Pousser les manifests dans votre repository git

#### Création du namespace 

Création du fichier namespace.yml
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```
Lancement du namespace
```bash
kubectl apply -f namespace.yml
kubectl get namespaces
kubectl get all -n kube-node-lease
```


#### Création des pods

Création du fichier pod-red.yml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-red
  labels:
    app: web
spec:
    containers:
    - name: simple-webapp-color
        image: mmumshad/simple-webapp-color
        env:
        - name: APP_COLOR
        value: red
```
Pour mentionner le namespace dans le fichier pod-red.yml, il faut ajouter la ligne suivante dans le fichier metadata:
```yaml
namespace: production
```
ou bien ajouter l'option -n production lors de l'execution de la commande kubectl apply
``` bash
kubectl apply -f pod-red.yml -n production
kubectl get pods -n production
```
Si vous savez que votre fichier sera utiliser ailleurs que dans le namespace production, il est préférable de ne pas mentionner le namespace dans le fichier yaml et de l'ajouter lors de l'execution de la commande kubectl apply.



Création du fichier pod-blue.yml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-blue
  labels:
    app: web
spec:
    containers:
    - name: simple-webapp-color
        image: mmumshad/simple-webapp-color
        env:
        - name: APP_COLOR
        value: blue
```

``` bash
kubectl apply -f pod-blue.yml -n production
kubectl get pods -n production
```

#### Création du service - rédaction du manifest du service nodeport

Création du fichier service-nodeport-web.yml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
    type: NodePort
    ports:
    - port: 8080
        targetPort: 8080
        nodePort: 30080
    selector:
        app: web
```

Attention, si vous voulez que votre service de type nodeport soit accessible par les autres pods il faut préciser le namespace dans le fichier yaml ou bien ajouter l'option -n production lors de l'execution de la commande kubectl apply.  
``` bash
kubectl apply -f service-nodeport-web.yml -n production
kubectl get svc -n production 
kubecct get services -n production
```
svc est l'abréviation de service

``` bash
kubectl describe svc service-nodeport-web -n production 
kubectl describe -n production svc service-nodeport-web
```

#### Vérification de l'application

``` bash
minikube service web -n production
```
lancer l'application sur le navigateur avec l'adresse suivante: http://http://192.168.64.2:30008/


### Résume de ce qui a été fait

Dans ce chapitre, nous avons vu comment créer un service de type nodeport.
- Création d'un namespace
- Création de deux pods
- Création d'un service de type nodeport
- Vérification de l'application

L'objectif de cette partie était de voir les services, services qui permettent de féderer les pods et de les rendre accessible aux autres pods. Ainsi rendre la communication entre les pods et l'utilisateur finale possible et transparente.
On a vue que les services de type :
- NodePort : permet d'exposer l'application à l'extérieur du cluster
- ClusterIP : permet d'exposer les pods uniquement à l'intérieur du cluster
- LoadBalancer : permet de créer un service qui va être provisionné sur un cloudprovider dont l'objectif est faire du LoadBalancing ( répartition la charge entre les noeuds du cluster) et dont une communication direct entre nos pods.
Permet de créer un service de type nodeport et d'ajouter un loadbalancer pour répartir la charge entre les noeuds du cluster
