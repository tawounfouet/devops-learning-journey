

### Création du fichier pod.yml

$ kubectl apply -f pod.yml

$ kubectl get po 

$ kubectl describe po _pod_name_

Commande pour exposer le port 8080 du pod vers le port 8080 de la machine hôte
$ kubectl port-forward simple-webapp-color 8080:8080 --address 0.0.0.0

### Création de l'objet de type deployment
Cet objet permet de gérer le nombre de pods qui seront créés et de gérer les mises à jour de l'application.
Il permet également de déployer un pod en suivant les meilleurs pratiques c-a-d (réplication, mise à jour, rollback, etc.)

Nous allons commencer par créer notre manifest (fichier de configuration) deployment.yml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
    replicas: 2
    strategy:
        type: RollingUpdate
        rollingUpdate:
        maxSurge: 1
        maxUnavailable: 1
    selector:
        matchLabels:
          app: nginx
    template:
        metadata:
        labels:
            app: nginx
        spec:
        containers:
        - name: nginx
          image: nginx:1.14.2
          ports:
            - containerPort: 80
    ```
Commande pour lancer la création du deployment
$ kubectl apply -f deployment.yml

Commande pour voir les deployments
$ kubectl get deployments
$ kubectl get deploy
$ kubectl get deploy --show-labels

Commande pour voir les replicasets
$ kubectl get rs
$ kubectl get rs --show-labels

Pour voir les détails de l'objet qui est encours de deployment (images, labels, selector, etc.)
$ kubectl get rs -o wide


$ kubectl get repkicasets
$ kubectl get repkicasets --show-labels

Le nom du replicaset est généré automatiquement par kubernetes et provient du nom du deployment
Allon modifier notre fichier deployment.yml et changer le nom de l'image de nginx:1.14.2 à nginx:lastest
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
    replicas: 2
    strategy:
        type: RollingUpdate
        rollingUpdate:
        maxSurge: 1
        maxUnavailable: 1
    selector:
        matchLabels:
          app: nginx
    template:
        metadata:
        labels:
            app: nginx
        spec:
        containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```
il faut appliquer les changements
$ kubectl apply -f deployment.yml

on voit que le nom du replicaset a changé, il reprend le nom du deployment et ajoute un hash à la fin.

Supprimer un deployment (Nettoyer l'environnement)
$ kubectl delete deployment nginx-deployment

Supprimer un pod créé par un fichier de configuration
$ kubectl delete -f pod.yml


Supprimer un pod créé par un deployment
$ kubectl delete pod _pod_name_

Cette action est équivalente à :kubectl delete -n default pod simple-webapp-color-v2


### Nous maintenant realiser les memes actions avec les actions imperatives (sans fichier de configuration)

Nous allons débuter par la création d'un pod (notre simple-webapp-color)
$ kubectl run simple-webapp-color-v2 --image=mmumshad/simple-webapp-color --env="APP_COLOR=blue" --restart=Never simple-webapp-color-v2

$ kubectl run simple-webapp-color-imp --image=mmumshad/simple-webapp-color \
--env="APP_COLOR=blue" \
--restart=Never \
simple-webapp-color-imp

$ kubectl run simple-webapp-color --image=kodekloud/webapp-color --port=8080 --labels="app=simple-webapp-color"
$ kubectl create deployment nginx-deployment --image=nginx:1.14.2

$ kubectl get pods
$ kubectl get pods -o wide

Commande pour exposer le port 8080 du pod vers le port 8080 de la machine hôte
$ kubectl port-forward simple-webapp-color 8080:8080 --address 0.0.0.0

$ kubectl expose pod simple-webapp-color --type=NodePort --port=8080 --name=webapp-service
$ kubectl expose pod simple-webapp-color --type=NodePort --port=8080 --name=webapp-service --dry-run=client -o yaml > svc.yaml

Suppresion de la resource créée (pod)
$ kubectl delete pod simple-webapp-color


Ensuite nous allons créer un deployment
$ kubectl create deployment --image=nginx:1.14.2 nginx-deployment-v2   
$ kubectl get deployments
$ kubectl get deploy

$ kubectl scale --replicas=2 deployment/nginx-deployment-v2
$ kubectl get deployments.apps

Changer l'image d'un deployment
$ kubectl set image deployment/nginx-deployment-v2 nginx=nginx:latest
$ kubectl get deployments.apps


Nous venons de voir comment créer un pod et un deployment, de facon imperative et declarative.
Pour un besoin de production, il est préférable d'utiliser la méthode declarative (fichier de configuration) car elle permet de versionner les changements et de les appliquer de facon simple et rapide.
Avantages (pour des besoins):
- Versionning
- Reutilisation
- Productiviilité
Ecrire toujours des manifestes parce que c'est plus facile à maintenir et à partager (votre collègue qui va recevoir le fichier après vous aura besoin de savoir ce que vous avez fait et comment vous l'avez fait)