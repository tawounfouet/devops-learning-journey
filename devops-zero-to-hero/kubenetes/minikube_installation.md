
## Minikube Installtion on Mac0s

### Install kubectl
```bash
brew install kubectl
```

### Install Minikube
```bash
brew install minikube
```

### Start Minikube - To Create kunernetes cluster
```bash
minikube start
minikube start --memory=4096  --driver=hyperkit 
minikube start --driver=hyperkit --cpus=4 --memory=4096
```


### Check Minikube Status
```bash
minikube status
```

### Stop Minikube
```bash
minikube stop
```

### Delete Minikube
```bash
minikube delete
```

### Check Minikube IP
```bash
minikube ip
```

### Check Minikube Dashboard
```bash
minikube dashboard
```

## Kubeflow Installation on Minikube

### Install kfctl
```bash
brew install kfctl
brew install kwctl
```

### Download Kubeflow
```bash
export KF_NAME=kf-test
export BASE_DIR=/Users/awf/Desktop
export KF_DIR=${BASE_DIR}/${KF_NAME}
mkdir -p ${KF_DIR}
cd ${KF_DIR}
export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v1.0-branch/kfdef/kfctl_k8s_istio.v1.0.2.yaml"
curl -O ${CONFIG_URI}
```

```bash
brew install kubeflow/tap/kfctl
```


### Deploy Kubeflow
```bash
kfctl apply -V -f ${CONFIG_FILE}
```

access_token="87Xho0DHkcQwaR/1aA9bIgPYk/pamRx9uTTytU4u8GY"


git clone https://<access_token>@github.com/kubeflow/homebrew-tap /usr/local/Homebrew/Library/Taps/kubeflow/homebrew-tap --origin=origin --template=

git clone https://"87Xho0DHkcQwaR/1aA9bIgPYk/pamRx9uTTytU4u8G"@github.com/kubeflow/homebrew-tap /usr/local/Homebrew/Library/Taps/kubeflow/homebrew-tap --origin=origin --template=

#### Using access token to clone kubeflow/homebrew-tap into /usr/local/Homebrew/Library/Taps/kubeflow/homebrew-tap
```bash
git clone https:// github.com/kubeflow/homebrew-tap /usr/local/Homebrew/Library/Taps/kubeflow/homebrew-tap --origin=origin --template=
```

#### Using access token to clone kubeflow/homebrew-tap into /usr/local/Homebrew/Library/Taps/kubeflow/homebrew-tap
```bash


```bash





git clone 
export KF_NAME=kf-test
export BASE_DIR=/Users/awf/Desktop
export KF_DIR=${BASE_DIR}/${KF_NAME}
mkdir -p ${KF_DIR}
cd ${KF_DIR}
export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v1.0-branch/kfdef/kfctl_k8s_istio.v1.0.2.yaml"
curl -O ${CONFIG_URI}
```

```bash



### Check Kubeflow Deployment
```bash
kubectl get all -n kubeflow
```

### Delete Kubeflow
```bash
kfctl delete -f ${CONFIG_FILE}
```

### Delete Kubeflow Namespace
```bash
kubectl delete ns kubeflow
```


