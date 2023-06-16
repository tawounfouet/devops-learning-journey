## TP-4 : Inventaire et variable

### Objectif

- Créer un cluster (1 ansible et 1 client)
- Créer un fichier `hosts.ini`au format ini avec les modalités d'inventaire suivant : 
    - Tous les hotes via le groupe `all` devront devoir avoir pour login user vagrant
    - Le client devra faire partir d'un groupe appelé `prod`
    - Le mot de passe à utiliser pour toutes les connexion ssh devra être `vagrant` pour toutes les machines du groupe `prod`
    - La variable `env` devra être égalent à `production` pour toutes les machines du groupe `prod`
- Créer ensuite un fichier `hosts.yml` version yaml du fichier `hosts.ini`
- Tester le commandes ad-hoc de ping et de setup sur les 2 fichiers d'inventaire


### Correction

```ini
[all:vars]
ansible_user=vagrant
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[prod]
client1 ansible_host=192.168.99.11

[prod:vars]
ansible_password=vagrant
env=production
```

```bash
ansible -i hosts.ini all -m ping # ping sur tous les hotes
ansible -i hosts.ini prod -m ping # ping sur le groupe prod
ansible -i hosts.ini client1 -m ping # ping sur le client1


ansible -i hosts.ini all -m copy -a "dest=/home/vagrant/inventaire_env.txt content='{{env}}'"
```

```yaml
all:
  vars:
    ansible_user: vagrant
    ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
prod:
  hosts:
    client1:
      ansible_host: 192.168.99.11
  vars:
    ansible_password: vagrant
    env: production
```

```bash
ansible -i hosts.yml all -m ping # ping sur tous les hotes
ansible -i hosts.yml prod -m ping # ping sur le groupe prod
ansible -i hosts.yml client1 -m ping # ping sur le client1

