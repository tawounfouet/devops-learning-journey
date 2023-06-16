
### Using Pods
https://kubernetes.io/docs/concepts/workloads/pods/ 
The following is an example of a Pod which consists of a container running the image nginx:1.14.2.
```bash
pods/simple-pod.yaml Copy pods/simple-pod.yaml to clipboard
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```
```bash
kubectl apply -f pods/simple-pod.yaml
```

This is the equivalent of running the following Docker command:
```bash
docker run --name nginx -p 80:80 nginx:1.14.2
```

A pod is just a specification of how to run a container. It is not a running container. To see the running containers, use the following command:
```bash
kubectl get pods
kubectl get pods -o wide # to see the IP address of the pod and the node it is running on
```
```bash

```
In docker you will run the following command to see the running containers:
```bash
docker ps
```

Details of the pod can be seen using the following command:
```bash


Print the logs for a container in a pod:
```bash
kubectl logs nginx
```

```bash
kubectl describe pod nginx
kubectl describe pod nginx | grep IP
```

```bash
kubectl delete pod nginx
```




## Using Deployments
https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
Wrapping a Pod in a Deployment is the recommended way to manage Pods.
A Pod is a single instance of an application. It is not a scalable object. If you want to scale your application, you need to create multiple Pods. Managing multiple Pods manually is difficult.
Kubenetes provides a higher level abstraction called a Deployment. It's what you should use to manage your Pods. It provides the following benefits:
- It provides a declarative way to define the desired state of your Pods and ReplicaSets.
- It provides a way to do rolling updates to your Pods.
- It provides a way to do rollbacks to previous versions of your Pods.

Use deployement to get features (advance capabilities) such as auto-scaling, auto-healing, rolling updates, and rollbacks.


More or less, what a kubenetes deployement does is that it adds a wrapper (layer of abstraction) on top of the pod. It is a declarative way to manage pods. It is a declarative way to manage pods and replica sets. It provides a way to do rolling updates to your pods. It is going to be the way  we deploy our applications to kubenetes in realtime production.


### Difference between a Container, Pod and a Deployment
- A container is a single instance of an application. It is not a scalable object. If you want to scale your application, you need to create multiple containers. Managing multiple containers manually is difficult.
- A Pod is a single or multiple containers that are deployed together on the same host. It is not a scalable object. If you want to scale your application, you need to create multiple Pods. Managing multiple Pods manually is difficult. 
- A Deployment is a scalable object. It manages multiple Pods for you. It provides declarative updates for Pods and ReplicaSets.

I can't understand the différence between container and pod (both are single instance of an application) and the différence between pod and deployment (both are scalable object). Can you explain me please ?


### ReplicaSets
https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/`
Replacasets --> kubenetes controller that ensures that a specified number of pod replicas are running at any given time.

It is a kunenetes controller that is implementing the auto-healing feature/capability on our pods.
It ensure that there is the same number of pods that where specified in the deployement.yml mananifest

A ReplicaSet is a scalable object. It manages multiple Pods for you. It provides declarative updates for Pods and ReplicaSets.
A ReplicaSet ensures that a specified number of pod replicas are running at any given time. However, a Deployment is a higher-level concept that manages ReplicaSets and provides declarative updates to Pods along with a lot of other useful features. Therefore, we recommend using Deployments instead of directly using ReplicaSets, unless you require custom update orchestration or don't require updates at all.


### Creating a Deployment
https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#creating-a-deployment
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```
```bash
kubectl apply -f deployments/nginx-deployment.yaml
```


```bash
kubectl get all # to see all the resources that have been created
kubectl get deployments # to see the deployments
kubectl get replicaset # to see the replicaset
kubectl get pods # to see the pods
```

Deployment is just a wrapper (specification of how to run a replicaset). It is the replicaset (controller) that is running the pods.

Kubernetes (in production scénario) is implementing the auto-healing capability on our pods with -> Deploy -> ReplicaSet -> Pods



## Using Services and Load Balancing
https://kubernetes.io/docs/concepts/services-networking/service/

SVC - Services

Why use services scénario : if you have multiple pods running the same application, you need a way to load balance between them. You need a way to access them. You need a way to access them from outside the cluster (from the internet). You need a way to access them from inside the cluster (from other pods). 
-> So use services to access pods from outside the cluster and from inside the cluster. 

Load balancing is the process of distributing network traffic across multiple servers. It ensures no single server bears too much demand. By spreading the work evenly, load balancing improves application responsiveness. It also increases availability of applications and websites for users


A Service in Kubernetes is an abstraction which defines a logical set of Pods and a policy by which to access them (sometimes this pattern is called a micro-service). The set of Pods targeted by a Service is (usually) determined by a selector (see below for why you might want a Service without a selector).

Avantages of using services:
- Load balancing
- Service discovery
- Expose apps to outside world
- No single point of failure
- Persistent IP to communicate with pods
- Pods can die and come back up, and the service will still be there to provide access to the pods
- Pods can be moved to other nodes, and the service will still be there to provide access to the pods
- Pods can be scaled up or down, and the service will still be there to provide access to the pods
- Pods can be terminated, and the service will still be there to provide access to the pods
  

#### ClusterIP mode
https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
ClusterIP is the default mode. It exposes the service on a cluster-internal IP. Choosing this value makes the service only reachable from within the cluster. This is the default ServiceType.

#### NodePort mode
https://kubernetes.io/docs/concepts/services-networking/service/#nodeport
NodePort mode exposes the service on each Node’s IP at a static port (the NodePort). A ClusterIP service, to which the NodePort service will route, is automatically created. You’ll be able to contact the NodePort service, from outside the cluster, by requesting <NodeIP>:<NodePort>.

#### LoadBalancer mode
https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer
LoadBalancer mode exposes the service externally using a cloud provider’s load balancer. NodePort and ClusterIP services, to which the external load balancer will route, are automatically created.

#### ExternalName mode
https://kubernetes.io/docs/concepts/services-networking/service/#externalname
ExternalName mode maps the service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up.

### Deactivate kubeflow-admin
```bash
kubectl config unset users.kubeflow-admin
```

#### Example of a django hello world app container from docker hub
https://hub.docker.com/r/abdelkrim/django-hello-world




### Labels and Selectors
https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#resources-that-support-set-based-requirements

Labels are key/value pairs that are attached to objects, such as pods. Labels are intended to be used to specify identifying attributes of objects that are meaningful and relevant to users, but do not directly imply semantics to the core system. Labels can be used to organize and to select subsets of objects. Labels can be attached to objects at creation time and subsequently added and modified at any time. Each object can have a set of key/value labels defined. Each Key must be unique for a given object.

Selectors are the core grouping primitive in Kubernetes. They are used by higher level primitives (for example, ReplicationControllers, ReplicaSets, Deployments, Jobs, and Services) to identify a logical set of Pods. Selectors are also used to identify the set of Pods to which a NetworkPolicy or PodSecurityPolicy applies.


```bash
kubectl get edit svc python-django-sample-app
```



## Using ConfigMaps
https://kubernetes.io/docs/concepts/configuration/configmap/
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/

ConfigMaps allow you to decouple configuration artifacts from image content to keep containerized applications portable. ConfigMaps can be used to store fine-grained information like individual properties or coarse-grained information like entire configuration files or JSON blobs. ConfigMaps are useful for storing and sharing non-sensitive, unencrypted configuration information.

ConfigMaps are key/value pairs that can be used within pods. They can be used to store configuration data that can be used by the application. They can be used to store environment variables, command-line arguments, configuration files, etc.

### Creating a ConfigMap
https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#create-configmaps-from-files

```bash
kubectl create configmap my-config --from-literal=key1=value1 --from-literal=key2=value2
```
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  key1: value1
  key2: value2
```

```bash
kubectl create configmap my-config --from-file=app_config.properties
```
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  app_config.properties: |
    key1=value1
    key2=value2
```



## Using Helm
https://helm.sh/docs/intro/quickstart/
https://helm.sh/docs/topics/charts/
https://helm.sh/docs/topics/charts/#charts
https://helm.sh/docs/topics/charts/#chart-best-practices
https://helm.sh/docs/topics/charts/#chart-license-readme-and-notes
https://helm.sh/docs/topics/charts/#chart-layout

Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.
Helm is the best way to find, share, and use software built for Kubernetes. Helm helps you manage Kubernetes applications — Helm Charts help you define, install, and upgrade even the most complex Kubernetes application.

A chart is a collection of files that describe a related set of Kubernetes resources. A single chart might be used to deploy something simple, like a memcached pod, or something complex, like a full web app stack with HTTP servers, databases, caches, and so on.

Charts are created as files laid out in a particular directory tree, then they can be packaged into versioned archives to be deployed. A chart can depend on other charts which are then fetched alongside it. This allows you to package up common sets of resources and easily reuse them. Charts are stored in a central repository called Helm Hub. You can also create your own repository to share charts within your organization. Helm Hub is a public repository of charts that anyone can publish to. It is hosted by the Helm project itself.

### Installing Helm
https://helm.sh/docs/intro/install/

```bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```


#### Installing Prometheus using Helm

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus
```




### Creating a chart for kubeflow
https://helm.sh/docs/topics/charts/#chart-license-readme-and-notes
https://helm.sh/docs/topics/charts/#chart-layout
https://helm.sh/docs/topics/charts/#charts

#### How to create a chart for kubeflow
https://gnovack.medium.com/automating-kubeflow-deployment-with-helm-and-aws-cdk-dd4c343ee2b5
```bash
helm create kubeflow
```

helm create central-dashboard




### Installing kubeflow using helm
https://www.kubeflow.org/docs/started/k8s/kfctl-k8s-istio/
https://www.kubeflow.org/docs/started/k8s/kfctl-existing-arrikto/
https://www.kubeflow.org/docs/started/k8s/kfctl-existing-eks/
https://www.kubeflow.org/docs/started/k8s/kfctl-existing-gke/
https://www.kubeflow.org/docs/started/k8s/kfctl-existing-k8s/
https://www.kubeflow.org/docs/started/k8s/kfctl-existing-k8s-istio/

```bash
helm repo add kubeflow https://kubeflow-charts.storage.googleapis.com/
helm repo update
helm install kubeflow kubeflow/kubeflow
```

Kubeflow installation using alauda repository
```bash
helm repo add alauda https://alauda.github.io/charts/
helm repo update
helm install kubeflow alauda/kubeflow
```

Kubeflow installation using istio repository
```bash
helm repo add istio https://storage.googleapis.com/istio-release/releases/1.9.0/charts/
helm repo update
helm install kubeflow istio/istio
```



Use another valid chart repository
```bash
helm install kubeflow kubeflow/kubeflow --repo https://charts.kubeflow.org/
```
```bash
helm install kubeflow kubeflow/kubeflow --repo https://kubeflow-charts.storage.googleapis.com/
```

#### Deleting helm repositories
```bash
helm repo remove kubeflow
helm repo remove alauda
helm repo remove prometheus-community
helm repo remove istio
```

