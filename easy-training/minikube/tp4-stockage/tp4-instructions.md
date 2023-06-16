## TP4 - Stockage Persistant

Ecrivez un fichier de déploiement pour un pod qui utilise un volume persistant pour stocker des données.
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mysql-volume
spec:
  containers:
  - name: mysql
    image: mysql:5.6
    env:
    - name: MYSQL_DATABASE
      value: eazytraining
    - name: MYSQL_USER
      value: eazy
    - name: MYSQL_PASSWORD
      value: eazy
    - name: MYSQL_ROOT_PASSWORD
      value: password
    volumeMounts:
    - name: mysql-persistent-storage
      mountPath: /var/lib/mysql
  volumes:
  - name: mysql-persistent-storage
    hostPath:
      path: /data-volume
      type: Directory
``` 
```bash
kubectl create -f mysql-volume.yml
kubectl apply -f mysql-volume.yml
kubectl get pods
kubectl describe pod mysql-volume
kubectl exec -it mysql-volume -- bash
mysql -u eazy -p
```

Pour supprimer le volume car pas fonctionné:
```bash
kubectl delete -f mysql-volume.yml
```

Nous avons oublier de créer le dossier /data-volume sur le noeud minikube:
```bash
minikube ssh
sudo mkdir /data-volume
exit
```



#### Création des volumes persistants et des claims
  - **pv.yml** : volume persistant de taille 1 Go utilisant le dossier local/data-pv pour stocker les données et 
  - **pvc.yml**: volume persistant claim de taille 100Mo utilisant le PV crée précédement pour stocker les données 

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/data-pv"
```
```bash
kubectl create -f pv.yml
kubectl get pv
kubectl describe pv pv
```

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 100Mi
```
```bash 
kubectl apply -f pvc.yml
kubectl get pvc
kubectl describe pvc pvc
```
