## Découverte du YAML

Le YAML est un langage de sérialisation de données. Il est utilisé dans de nombreux projets comme Ansible, Kubernetes, Docker, etc...

Premier exemple de fichier YAML:

```yaml
---
all:
  hosts:
    192.168.99.11:
      ansible_user: vagrant
      ansible_password: vagrant
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
    192.168.99.12:
      ansible_user: vagrant
      ansible_password: vagrant
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
```
$ ansible -i hosts all -m ping
$ ansible -i hosts all -m copy -a "dest=/home/vagrant/yaml.txt content='Hello Thomas, japprend du YAML'"
```