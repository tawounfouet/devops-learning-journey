## Déploiement de l'application Oddo

### Prérequis

- Avoir un cluster Kubernetes fonctionnel
- Avoir un namespace dédié à l'application Oddo
- Avoir un namespace dédié à l'application Prometheus

### Déploiement de l'application Oddo
- Installer helm sur votre machine/cluster
- Utiliser le chart helm l'application oddo pour déployer l'application
- Désactiver toutes les options de persistance de données (oddo et postgresql)
- Exposer l'application via un service de type NodePort (port 30069)
- Créer un fichier value.yaml contenant toutes les variables que vous avez à surcharger sur le chart helm et poussez le sur git le repo git dans le dossier que vous allez appeler lab-0
- Vérifier que l'application est bien accessible via le service crée (que l'app est déployée et fonctionnelle) 


### Solution

#### Installer helm sur votre machine/cluster
```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
```
```bash
chmod 700 get_helm.sh
```
```bash
./get_helm.sh
```

#### Utiliser le chart helm l'application oddo pour déployer l'application
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```
```bash
helm install oddo bitnami/odoo
```
Create a NodePort mode my-oddo service
```bash
kubectl expose service my-oddo-odoo --type=NodePort --target-port=8069 --name=my-oddo-odoo-ext
```
```bash
helm install oddo bitnami/odoo --set service.type=NodePort --set service.nodePort=30069
```



surcharge des valeurs par défaut du chart helm oddo
```bash
helm install oddo bitnami/odoo -f values.yml

helm install oddo bitnami/odoo --set service.type=NodePort --set service.nodePort=30069
```

suppimer le chart helm oddo
```bash
helm uninstall oddo
```

1. Get the Odoo URL by running:
```bash
export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services oddo-odoo)
export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")

echo "Odoo URL: http://$NODE_IP:$NODE_PORT/"
```
Odoo URL: http://192.168.64.9:30069/

2. Obtain the login credentials
```bash
export ODOO_EMAIL=user@example.com
export ODOO_PASSWORD=$(kubectl get secret --namespace "default" oddo-odoo -o jsonpath="{.data.odoo-password}" | base64 -d)
echo Email   : $ODOO_EMAIL
echo Password: $ODOO_PASSWORD
```
Email : user@example.com
Password: dz0UXyOehI