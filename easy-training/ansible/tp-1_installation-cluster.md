## Ansible Setup for Easy Training


#### Installation ansible et client
```bash
git clone https://github.com/diranetafen/cursus-devops.git 
cd cursus-devops/vagrant/ansible
vagrant up
vagrant ssh ansible
```

####  Installer docker sur la machine client
```bash
ansible-galaxy install geerlingguy.pip
ansible-galaxy install geerlingguy.docker
```

```bash
mkdir docker && cd docker
vi hosts.ini
touch install_docker.yml
```

```ini
#client1 ansible_host=192.168.99.11 ansible_user=vagrant ansible_ssh_private_key_file=/home/vagrant/.ssh/id_rsa
#client1 ansible_host=192.168.99.11 ansible_user=vagrant ansible_password=vagrant
client1 ansible_host=192.168.99.11 ansible_user=vagrant ansible_password=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_python_interpreter=/usr/bin/python3
```

$ vi install_docker.yml
$
```yaml
- hosts: all
  become: yes
  vars:
    pip_install_packages:
      - name: docker
    docker_users:
      - vagrant
  roles:
    - geerlingguy.pip
    - geerlingguy.docker
```

$ sudo yum install -y sshpass
$



#### Créer les fichiers hosts.ini et install_docker.yml
#### Lancer le déploiement: 
```bash
ansible-playbook -i hosts.ini install_docker.yml
```


Creation du playbook nginx.ym`
$ vi nginx.yml
$
```bash
---
- hosts: all
  tasks:
  - name: nginx
    docker_container:
      name: nginx
      image: nginx
      ports:
        - "80:80"
```


#### Test
```bash
 ansible-playbook -i hosts.ini nginx.yml
```

##### Error docker ps
The "permission denied" error you encountered while trying to run docker ps indicates that the current user vagrant does not have the necessary permissions to access the Docker daemon. To fix this, you can follow these steps:
```bash
# Add the vagrant user to the docker group:
sudo usermod -aG docker vagrant

# Log out and log back in again to pick up the new group permissions
exit
vagrant ssh

# Verify that the vagrant user is now part of the docker group:
groups vagrant
```




$ vagrant suspend
$ vagrant resume









#### Mise à jour du système
```bash
  sudo yum update -y
```  
#### installer les release epel
```bash
  sudo yum install epel-release -y
```  
#### Installer Ansible
```bash
  sudo yum install ansible -y 
```  
#### Vérifier la version de ansible
```bash
  ansible --version
```

#### Si vous voulez la dernière version et non celle sur epel
```bash
  pip install ansible
```

#### Avec python3, installation de pip3
```bash
  curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3
  pip3 install ansible
```