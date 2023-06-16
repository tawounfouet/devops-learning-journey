

#### ID d’instance
i-07d6ce5574a558d8b (devops-server)
Ouvrez un client SSH.

Recherchez votre fichier de clé privée. La clé utilisée pour lancer cette instance est devops.pem

Exécuter, si nécessaire, cette commande pour vous assurer que votre clé n’est pas visible publiquement.
 chmod 400 devops.pem

Connectez-vous à votre instance à l’aide de son DNS public :
 ec2-35-180-114-95.eu-west-3.compute.amazonaws.com

#### Exemple :

 ssh -i "devops.pem" ubuntu@ec2-35-180-114-95.eu-west-3.compute.amazonaws.com



 ### Installation de Docker-compose
 https://docs.docker.com/compose/install/linux/ 
    
     ```
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins

curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose

chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
```
```
sudo apt-get install docker-compose
```
```