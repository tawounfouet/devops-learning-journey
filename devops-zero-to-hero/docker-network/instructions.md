## Networking in Docker

### Docker Network

Docker network is a virtual network that enables containers to communicate with each other and with the outside world. Docker network is created using the `docker network create` command. The command creates a bridge network by default. The bridge network is a private internal network created by Docker on the host. The bridge network is isolated from the host network and other bridge networks by default. The containers in the bridge network can communicate with each other using the container name. The containers in the bridge network can communicate with the outside world using the port mapping feature of Docker.

$ docker network create my-network
$ docker network ls
docker network inspect my-network

### Docker Network Types

Docker supports the following network types:
- Bridge Network : Default network type in Docker, containers are attached to a bridge network by default
- Host Network : Containers share the host network, containers are attached to the host network directly 
- Overlay Network : Used in Docker Swarm, containers are attached to an overlay network 
- Macvlan Network : Containers are attached to a physical network
- None Network : Containers are not attached to any network

$ docker network create --driver bridge my-bridge-network
$ docker network create --driver host my-host-network
$ docker network create --driver overlay my-overlay-network


$ docker run -d --name login-container nginx:latest
$ docker run -d --name logout-container nginx:latest
$ docker run -d --name payment-container nginx:latest
$ docker run -d --name order-container nginx:latest

$ docker exec -it login-container /bin/bash
 "IPAddress": "172.17.0.2",
```bash
$ apt-get update
$ apt-get install -y iputils-ping
$ ping -V
$ ping payment-container
$ ping order-container
$ ping google.com
```

$ docker exec -it logout-container /bin/bash
 "IPAddress": "172.17.0.3",


To view the IP address of a container, use the `docker inspect` command.
$ docker inspect login-container


Create a network in docker
$ docker network create my-first-network
$ dcoker network create secure-network
$ docker network create --driver bridge my-first-network

Delete a network in docker
$ docker network rm my-first-network

Run a container in a network - with the secure-network 
$ docker run -d --name finance --network=secure-network nginx:latest
```bash
docker exec -it finance /bin/bash
 "IPAddress": "172.23.0.2",
````

$ docker run -d --name host-demo --network=host nginx:latest
```bash
docker exec -it host-demo /bin/bash
 "IPAddress": ""
```
This container is attached to the host network. The container does not have an IP address. The container shares the host network with the host machine. The container can communicate with the host machine using the localhost address.
