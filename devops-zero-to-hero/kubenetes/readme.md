## Kubernetes Architecture

### Kubernetes Master
The Kubernetes master is responsible for maintaining the desired state for your cluster. When you interact with Kubernetes, such as by using the kubectl command-line interface, you’re communicating with your cluster’s Kubernetes master. When you use the Kubernetes API, you’re communicating with the Kubernetes master. Each Kubernetes cluster has one master. 

### Kubernetes Nodes
A Kubernetes node is a virtual machine (VM) or a physical machine that serves as a worker machine in a Kubernetes cluster. Each node has a Kubelet, which is an agent for managing the node and communicating with the Kubernetes master. The node should also have tools for handling container operations, such as Docker or rkt. A Kubernetes cluster that handles production traffic should have a minimum of three nodes.

### Kubernetes Pod
A pod is a group of one or more containers, with shared storage/network, and a specification for how to run the containers. A pod’s contents are always co-located and co-scheduled, and run in a shared context. A pod models an application-specific “logical host” - it contains one or more application containers which are relatively tightly coupled — in a pre-container world, they would have executed on the same physical or virtual machine.

### Kubernetes Service
A Kubernetes Service is an abstraction which defines a logical set of Pods and a policy by which to access them - sometimes called a micro-service. The set of Pods targeted by a Service is (usually) determined by a Label Selector (see below for why you might want a Service without a selector).

### Kubernetes Volume
A Kubernetes volume, on the other hand, has an explicit lifetime - the same as the Pod that encloses it. Consequently, a volume outlives any Containers that run within the Pod, and data is preserved across Container restarts. Of course, when a Pod ceases to exist, the volume will cease to exist, too. Perhaps more importantly than this, Kubernetes supports many types of volumes, and a Pod can use any number of them simultaneously.

### Kubernetes Namespace
Namespaces are intended for use in environments with many users spread across multiple teams, or projects. For clusters with a few to tens of users, you should not need to create or think about namespaces at all. Start using namespaces when you need the features they provide.

### Kubernetes Label
Labels are key/value pairs that are attached to objects, such as pods. Labels are intended to be used to specify identifying attributes of objects that are meaningful and relevant to users, but do not directly imply semantics to the core system. Labels can be used to organize and to select subsets of objects. Labels can be attached to objects at creation time and subsequently added and modified at any time. Each object can have a set of key/value labels defined. Each Key must be unique for a given object.

### Kubernetes Annotation
Annotations are similar to labels, but they are not used to identify and select objects. Instead, annotations are used to store non-identifying auxiliary data, for bookkeeping purposes. The metadata.annotations field is a key-value map stored with a resource that can be larger than labels and is intended to store more structured information. The field can be set in a manifest file, or via the command-line, or set by client libraries or other tools after the resource has been created. The field is not queryable.

### Kubernetes Deployment
A Deployment controller provides declarative updates for Pods and ReplicaSets. You describe a desired state in a Deployment object, and the Deployment controller changes the actual state to the desired state at a controlled rate. You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.

### Kubernetes ReplicaSet
A ReplicaSet ensures that a specified number of pod replicas are running at any given time. However, a Deployment is a higher-level concept that manages ReplicaSets and provides declarative updates to Pods along with a lot of other useful features. Therefore, we recommend using Deployments instead of directly using ReplicaSets, unless you require custom update orchestration or don’t require updates at all.

### Kubernetes DaemonSet
A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created.

### Kubernetes Job
A Job creates one or more Pods and ensures that a specified number of them successfully terminate. As pods successfully complete, the Job tracks the successful completions. When a specified number of successful completions is reached, the task (ie, Job) is complete. Deleting a Job will clean up the Pods it created. A simple case is to create one Job object in order to reliably run one Pod to completion. The Job object will start a new Pod if the first Pod fails or is deleted (for example due to a node hardware failure or a node reboot).



## Kuneernetes Control Plane
The Kubernetes control plane consists of various components, each its own process, that can run both on a single master node or on multiple masters supporting high-availability clusters. These components communicate with each other and the rest of the cluster through the Kubernetes API, which the control plane exposes.

### Kubernetes API Server
The API server is a component of the Kubernetes control plane that exposes the Kubernetes API. The API server is the front end for the Kubernetes control plane.

### Kubernetes Scheduler
The Kubernetes scheduler is a component of the control plane that watches for newly created Pods with no assigned node, and selects a node for them to run on.

### Kubernetes Controller Manager
The Kubernetes controller manager is a daemon that embeds the core control loops shipped with Kubernetes. In applications of robotics and automation, a control loop is a non-terminating loop that regulates the state of the system. In Kubernetes, a controller is a control loop that watches the shared state of the cluster through the API server and makes changes attempting to move the current state towards the desired state. Examples of controllers that ship with Kubernetes today are the replication controller, endpoints controller, namespace controller, and serviceaccounts controller.

### Kubernetes etcd
Consistent and highly-available key value store used as Kubernetes’ backing store for all cluster data.

### Kubernetes Cloud Controller Manager
The cloud controller manager is a Kubernetes control plane component that embeds cloud-specific control logic. The cloud controller manager lets you link your cluster into your cloud provider’s API, and separates out the components that interact with that cloud platform from components that just interact with your cluster. For example, when a node needs to be created, the cloud controller manager communicates with your cloud provider’s API to create a node, then passes that node to the node controller to manage. The cloud controller manager lets you swap out the cloud-provider-specific code without impacting the core Kubernetes code.

### Kubernetes Container Runtime
The container runtime is the software that is responsible for running containers. Kubernetes supports several container runtimes: Docker, containerd, CRI-O, and any implementation of the Kubernetes CRI (Container Runtime Interface).

### Kubernetes kubelet
An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.

### Kubernetes kube-proxy
kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.

### Kubernetes Addons
Addons use Kubernetes resources (DaemonSet, Deployment, etc) to implement cluster features. Because these are providing cluster-level features, namespaced resources used by addons are located in the kube-system namespace.

### Kubernetes DNS
While the Kubernetes DNS is a cluster addon, it is implemented slightly differently. Rather than running as a Deployment or DaemonSet, the DNS addon is installed by the cluster provisioner (kops, kubeadm, etc) as a set of static pods on the kube-system namespace. This is done to ensure that DNS is available as soon as the cluster is up and running.

### Kubernetes Web UI (Dashboard)
Dashboard is a general purpose, web-based UI for Kubernetes clusters. It allows users to manage and troubleshoot applications running in the cluster, as well as the cluster itself.

### Kubernetes Container Resource Monitoring
Container Resource Monitoring records generic time-series metrics about containers in a central database, and provides a UI for browsing that data.

### Kubernetes Cluster-level Logging
Cluster-level logging provides a centralized mechanism for storing, searching, and viewing aggregated logs across all namespaces and containers in a Kubernetes cluster.

### Kubernetes Federation
Federation allows you to manage multiple Kubernetes clusters from a single API endpoint. It does this by syncing resources between a central control plane and a set of clusters.

### Kubernetes Ingress Controller
Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.

### Kubernetes Load Balancer
A cloud provider load balancer provisions a load balancer in the external cloud provider, and distributes incoming traffic among the Pods of the Service it exposes.

### Kubernetes Persistent Volumes
PersistentVolumes (PVs) are a way for users to “claim” durable storage (such as a GCE PersistentDisk or an iSCSI volume) without knowing the details of the particular cloud environment.

### Kubernetes Storage Classes
StorageClasses are a way for administrators to describe the “classes” of storage they offer. Different classes might map to quality-of-service levels, or to backup policies, or to arbitrary policies determined by the cluster administrators. Kubernetes itself is unopinionated about what classes represent. This concept is sometimes called “profiles” in other storage systems.

### Kubernetes Volume Snapshots
VolumeSnapshot objects represent a saved state of a volume. They can be used by VolumeSnapshotContent objects to provision new volumes pre-populated with data from the saved state of a volume.

## Kubernetes Data Plane
The Kubernetes data plane consists of the set of nodes that run applications and cloud workflows. The Kubernetes data plane is designed to be extensible and pluggable. It supports a wide variety of container runtimes and network implementations.

### Kubernetes Node
A node is a worker machine in Kubernetes and may be either a virtual or a physical machine, depending on the cluster. Each node contains the services necessary to run Pods and is managed by the master components. The services on a node include the container runtime, kubelet and kube-proxy.

### Kubernetes Pod
A Pod is the basic building block of Kubernetes–the smallest and simplest unit in the Kubernetes object model that you create or deploy. A Pod represents a running process on your cluster.

### Kubernetes Container
A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another.

### Kubernetes Container Runtime
The container runtime is the software that is responsible for running containers. Kubernetes supports several container runtimes: Docker, containerd, CRI-O, and any implementation of the Kubernetes CRI (Container Runtime Interface).

### Kubernetes kubelet
An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.

### Kubernetes kube-proxy
kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.

### Kubernetes Addons
Addons use Kubernetes resources (DaemonSet, Deployment, etc) to implement cluster features. Because these are providing cluster-level features, namespaced resources used by addons are located in the kube-system namespace.