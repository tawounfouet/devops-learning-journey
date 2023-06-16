#!/bin/bash

## Install Jenkins

IP=$(hostname -I | awk '{print $2}')

echo "START - Install Jenkins - $IP"

# Install utils & Ansible
apt-get update -qq >/dev/null
apt-get install -qq -y git sshpass wget ansible gnupg2 curl >/dev/null

# Install Java & Jenkins
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list
apt-get update -qq >/dev/null
apt-get install -qq -y default-jre jenkins >/dev/null

# Enable and start Jenkins service
systemctl enable jenkins
systemctl start jenkins

# Ansible custom configurations
sed -i 's/.*pipelining.*/pipelining = True/' /etc/ansible/ansible.cfg
sed -i 's/.*allow_world_readable_tmpfiles.*/allow_world_readable_tmpfiles = True/' /etc/ansible/ansible.cfg

# Install Docker & Docker Compose
curl -fsSL https://get.docker.com | sh >/dev/null
usermod -aG docker jenkins
curl -sL "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Use registry without SSL
echo '{
  "insecure-registries" : ["192.168.5.5:5000"]
}' > /etc/docker/daemon.json

systemctl daemon-reload
systemctl restart docker

echo "END - Install Jenkins"
