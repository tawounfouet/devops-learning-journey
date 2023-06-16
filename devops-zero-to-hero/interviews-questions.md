## Docker interview questions

1. What is Docker?
Dockers is a containerization platform that packages your application and all its dependencies together in the form of containers so as to ensure that your application works seamlessly in any environment be it development or test or production.

2. What is the difference between Docker Image and Docker Container?
Docker Image is a template for creating Docker containers. It contains all the necessary dependencies and other things required for an application to run as Docker container. Docker Container is created from Docker Image and it is the actual runtime component of Docker. Docker Container is created from Docker Image and it is the actual runtime component of Docker.

3. What is Docker Engine?
Docker Engine is a containerization technology that is used to build and test container images. It is the core part of Docker and is a lightweight program running on the host machine. It builds and runs the container images.

4. What is Docker Hub?
Docker Hub is a cloud-based registry service which allows you to link to code repositories, build your images and test them, stores manually pushed images, and links to Docker Cloud so you can deploy images to your hosts. It provides a centralized resource for container image discovery, distribution and change management, user and team collaboration, and workflow automation throughout the development pipeline.

5. How containers are different from virtual machines?
Containers are an abstraction at the app layer that packages code and dependencies together. Multiple containers can run on the same machine and share the OS kernel with other containers, each running as isolated processes in user space. Containers take up less space than VMs (container images are typically tens of MBs in size), can handle more applications and require fewer VMs and Operating systems.

6. What is Docker Swarm?
Docker Swarm is a clustering and scheduling tool for Docker containers. With Swarm, IT administrators and developers can establish and manage a cluster of Docker nodes as a single virtual system. Swarm mode also provides a fault-tolerant mechanism in which services can continue running uninterrupted on remaining nodes if a node fails.

7. What is Docker Compose?
Docker Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

8. What is Dockerfile?
Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succession.

9. WHat is the difference between dockerwarn and docker-compose?
Docker Swarm is a clustering and scheduling tool for Docker containers. With Swarm, IT administrators and developers can establish and manage a cluster of Docker nodes as a single virtual system. Swarm mode also provides a fault-tolerant mechanism in which services can continue running uninterrupted on remaining nodes if a node fails. Docker Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

10. What is kubenetes?
Kubernetes is an open-source container-orchestration system for automating deployment, scaling and management of containerized applications. It was originally designed by Google and is now maintained by the Cloud Native Computing Foundation.


11. What is the difference between Docker Swarm and Kubernetes?
Docker Swarm is a clustering and scheduling tool for Docker containers. With Swarm, IT administrators and developers can establish and manage a cluster of Docker nodes as a single virtual system. Swarm mode also provides a fault-tolerant mechanism in which services can continue running uninterrupted on remaining nodes if a node fails. Kubernetes is an open-source container-orchestration system for automating deployment, scaling and management of containerized applications. It was originally designed by Google and is now maintained by the Cloud Native Computing Foundation.


12. What is docker lifecycle?
Docker lifecycle is the process of building, deploying and maintaining the docker containers.
- writing a dockerfile (sets of instructions that are require to build an image)
```bash
FROM ubuntu:latest
```
- building/create an image from the dockerfile using docker build command 
```bash
docker build -t <image-name> .
```
- running the container using docker run command
```bash
docker run -it <image-name>
```
- pushing the image to docker hub (registery) using docker push command
```bash
docker push <image-name>
```
- pulling the image from docker hub using docker pull command
```bash
docker pull <image-name>
```
- removing the image using docker rmi command
```bash
docker rmi <image-name>
```
- removing the container using docker rm command
```bash
docker rm <container-name>
```


13. What are the differents docker components?
- Docker Client: It is the primary user interface to Docker. It accepts commands from the user and communicates back and forth with a Docker daemon.
- Docker Daemon: It is also called as Docker Engine. It is a background process which runs on the host machine responsible for building and running of containers.
- Docker CLI: It is a command line tool used to interact with Docker daemon. It is used to run Docker commands.
- Docker Image: It is a read-only template used to build containers. Images are used to store and ship applications.
- Docker Container: It is a runnable instance of an image. You can create, start, stop, move, or delete a container using the Docker API or CLI.


14. What are the different Network types in Docker?
- Bridge Network: It is the default network type in Docker. It provides a bridge between the docker containers and the host machine. It is useful for standalone containers.
- Host Network: It removes the network isolation between the docker container and the host machine. It is useful for standalone containers and for situations where you don’t want to container to be isolated from the host machine.
- None Network: It removes the eth0 interface from the container. It is useful in situations where you want to completely disable the networking stack on the container.
- Overlay Network: It is used to connect multiple Docker daemons. It is useful for swarm services running on different Docker hosts to communicate with each other.
- Macvlan Network: It assigns a MAC address to the container. It is useful in situations where you want the container to look like a physical device on your network.
- Network Plugins: It is used to integrate Docker with specialized network stacks


15. Can you explain how to isolate networking between Docker containers?
Docker provides different network drivers that allow you to isolate network traffic between containers. You can use the --network flag to specify which network to use when creating a new container. The default network is bridge. You can also create your own network using the docker network create command. You can also use the --link flag to link two containers together. This will create a secure tunnel between the containers over which they can communicate.

16. Can you explain the docker architecture?
Docker uses a client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers. The Docker client and daemon can run on the same system, or you can connect a Docker client to a remote Docker daemon. The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface.

17. What is Docker Registry?
Docker Registry is a stateless, highly scalable server-side application that stores and lets you distribute Docker images. It stores the images for Docker Engine to use when creating new container instances. By default, Docker Engine looks for images on Docker Hub, which is Docker’s public registry where you find official images for Dockerized applications and base images for other Docker images. You can even run your own private registry.
Examples of some public registries are:
- Docker Hub
- Quay
- Google Container Registry
- Amazon EC2 Container Registry
- Azure Container Registry

1.  What is a mukti-stage build in Docker?
Multi-stage builds are a new feature requiring Docker 17.05 or higher on the daemon and client.
Multistage builds are useful to anyone who has struggled to optimize Dockerfiles while keeping them easy to read and maintain. Multistage builds are useful to anyone who has struggled to optimize Dockerfiles while keeping them easy to read and maintain.
Give a simple example of a multistage build:
```bash
# First stage: build the executable.
FROM golang:1.7.3 AS builder
WORKDIR /go/src/github.com/alexellis/href-counter/
RUN go get -d -v golang.org/x/net/html
COPY app.go    .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Second stage: create the bare-minimum executable.
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/

# Copy the executable from the first stage.
COPY --from=builder /go/src/github.com/alexellis/href-counter/app .
CMD ["./app"]
```
In this example, the first stage of the build creates a binary from the golang-based image, and the second stage copies the binary from the first stage into the much smaller alpine image. The resulting image is smaller because it doesn’t include the intermediate layers from the first stage.

17. What is the difference between ADD and COPY in Dockerfile?
The COPY instruction copies new files or directories from <src> and adds them to the filesystem of the container at the path <dest>.
```bash
COPY [--chown=<user>:<group>] <src>... <dest>
COPY [--chown=<user>:<group>] ["<src>",... "<dest>"] (this form is required for paths containing whitespace)
```
The ADD instruction copies new files, directories or remote file URLs from <src> and adds them to the filesystem of the image at the path <dest>.
```bash
ADD [--chown=<user>:<group>] <src>... <dest>
ADD [--chown=<user>:<group>] ["<src>",... "<dest>"] (this form is required for paths containing whitespace)
```
The main difference between ADD and COPY is that ADD allows <src> to be an URL. If you have local content to add to your image, always use COPY because it is more transparent. COPY only supports the basic copying of local files into the container, while ADD has some features (like local-only tar extraction and remote URL support) that are not immediately obvious. Consequently, the best use for ADD is local tar file auto-extraction into the image, as in ADD rootfs.tar.xz /.

18. What is the difference between CMD and ENTRYPOINT in Dockerfile?
CMD is used to provide default arguments for the ENTRYPOINT instruction, that is, the default executable to run when the container starts.
```bash
CMD ["executable","param1","param2"] (exec form, this is the preferred form)
CMD ["param1","param2"] (as default parameters to ENTRYPOINT)
CMD command param1 param2 (shell form)
```
ENTRYPOINT is used to configure a container that will run as an executable.
```bash
ENTRYPOINT ["executable", "param1", "param2"] (exec form, preferred)
ENTRYPOINT command param1 param2 (shell form)]
```
The main purpose of a CMD is to provide defaults for an executing container. These defaults can include an executable, or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.


## Real Time Challenges with Docker 

1. Docker is a single deamon process, so if it goes down, all the containers go down. Which can cause a single point of failure. If the docker deamon goes down for some reason, all the containers/applications go down.
How to solve this problem?
- Docker Swarm
- Kubernetes

2. Docker Daemon run as a root user, so if any container is compromised, it can compromise the whole system. 
It's a security risk/threat. Any process running as a root user can have adverse effects on the system. When it is compormised for security reasons, it can be a big problem and can impact other applications or containers running on the same system/host.
How to solve this problem?
- Docker Daemon can be run as a non-root user.
- Docker Daemon can be run in a VM

3. Resource Constraints: Docker containers can consume all the resources on the host machine. It can cause a single point of failure. If one container is consuming all the resources, it can impact other containers running on the same host.
If you are running too many containers on the same host, you can experience issues woth resource constraints. This can resullt in a slow performance of the application or the application can crash.
How to solve this problem?
- Resource Constraints can be applied to the containers.
- Docker Swarm
- Kubernetes


## What steps will you take to secure a Docker container?

1. Use distrolss images or images with minimal packages as your final image in multi-stage builds, so that you don't have to worry about patching the packages and that there is less chance of CVEs and security vulnerabilities/issues.

2. Ensure that the networking is configured properly. Don't expose the ports that are not required. Don't expose the ports to the public internet. Use a reverse proxy to expose the ports to the public internet. This is one of the most common reasons for security issues. If required configure custom bridge networks and use them to connect the containers. Don't use the default bridge network. Assing them to isolate containers.

3. Use utilities like Sync to scan the images for vulnerabilities. Scan the images regularly and patch them.


- Use trusted base images
- Minimize the number of layers
- Scan and patch regularly
- Use secrets instead of environment variables
- Use multi-stage builds
- Use docker security tools
- Use docker security scanning tools
- Use docker security best practices
- Use docker security best practices for dockerfiles
- Use docker security best practices for docker images
- Use docker security best practices for docker containers
- Use docker security best practices for docker networks
- Use docker security best practices for docker volumes
- Use docker security best practices for docker secrets
- Use docker security best practices for docker swarm
- Use docker security best practices for docker compose
- Use docker security best practices for docker machine
- Use docker security best practices for docker hub
- Use docker security best practices for docker registry

