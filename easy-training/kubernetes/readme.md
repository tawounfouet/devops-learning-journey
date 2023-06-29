## Creation d'un cluster EKS


### Connexion à l'instance EC2
Ouvrez un client SSH.



Exécuter, si nécessaire, cette commande pour vous assurer que votre clé n’est pas visible publiquement.
 chmod 400 devops-virginia.pem

Connectez-vous à votre instance à l’aide de son DNS public :
 ec2-3-83-113-112.compute-1.amazonaws.com

Exemple :

 ssh -i "devops-virginia.pem" ubuntu@ec2-3-83-113-112.compute-1.amazonaws.com



### Gestion des cles d'acces pour pourvoir utiliser aws-cli



### Creation du cluster EKS

sudo apt update
sudo apt install -y unzip
