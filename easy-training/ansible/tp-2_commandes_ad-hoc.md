## Utilisation des commandes ad-hoc

- Créer fichier d'inventaire hosts.ini
- Utiliser une commande ad-doc pour tentez de pinger le clien ansible
- Utiliser une commande ad-doc pour créer un fichier toto.txt sur le client ansible avec le contenu "Hello Thomas, j'apprend Ansible" et qui se trouvera dans le dossier /home/vagrant/toto.txt sur le client ansible
- Vérifier que le fichier toto.txt a bien été créé sur le client ansible avec son contenu bien sûr
- Rajoutez un client et modifier le fichier inventaire hosts.ini afin de rajouter le nouveau client
- Relancez l'action de ping et de création de fichier ssur les 2 clients maintenant vérifiez le résultat
- Testez l'effet module setup sur votre inventaire hosts.ini


### Correction

```bash
# Créer fichier d'inventaire hosts.ini
#vi hosts.ini
```ini
client1 ansible_host=192.168.99.11 ansible_user=vagrant ansible_password=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_python_interpreter=/usr/bin/python3
```

```bash
# Utiliser une commande ad-doc pour tentez de pinger le clien ansible
ansible -i hosts.ini all -m ping
```

```bash
# Utiliser une commande ad-doc pour créer un fichier toto.txt sur le client ansible avec le contenu "Hello Thomas, j'apprend Ansible" et qui se trouvera dans le dossier /home/vagrant/toto.txt sur le client ansible
ansible -i hosts.ini all -m shell -a "echo 'Hello Thomas, japprend Ansible' > /home/vagrant/toto.txt"
ansible -i hosts.ini all -m copy -a "dest=/home/vagrant/toto.txt content='Hello Thomas, japprend Ansible'"

# Vérifier que le fichier toto.txt a bien été créé sur le client ansible avec son contenu bien sûr
```

```bash
# Rajoutez un client et modifier le fichier inventaire hosts.ini afin de rajouter le nouveau client
client1 ansible_host=192.168.99.11 ansible_user=vagrant ansible_password=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_python_interpreter=/usr/bin/python3

client2 ansible_host=192.168.99.12 ansible_user=vagrant ansible_password=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_python_interpreter=/usr/bin/python3
```

```bash
# Relancez l'action de ping et de création de fichier ssur les 2 clients maintenant vérifiez le résultat
ansible -i hosts.ini all -m ping
```

```bash
# Testez l'effet module setup sur votre inventaire hosts.ini
## Le module setup permet de récupérer des informations sur les machines cibles (hostname, ip, interfaces réseaux, etc...) en gros il permet de découvrir les machines cibles
ansible -i hosts.ini all -m setup
```
