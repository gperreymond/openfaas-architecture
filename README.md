# Infrastructure

## 1) First Minikube baby!

- https://kubernetes.io/docs/tasks/tools/install-minikube/
- https://kubernetes.io/fr/docs/setup/learning-environment/minikube/

### Run on Ubuntu the easy way!

```sh
# sometimes you will need this!
sudo chown -R $USER:$USER /etc/kubernetes
sudo chown -R $USER:$USER ~/.kube
sudo chown -R $USER:$USER ~/.minikube

# The "none" driver requires root privileges.
sudo minikube start --vm-driver=none
kubectl config use-context minikube

# warning: addons to enable
minikube addons enable ingress
minikube addons enable ingress-dns
# verify addons enabled
minikube addons list

# expose on localhost
kubectl expose deployment nginx-ingress-controller -n kube-system --target-port=80 --type=NodePort

# look the minikube ip
minikube ip
```

You are ready to rumble!

### You can have a kubernetes dashboard

```sh
minikube dashboard
```

## 2) Install & Configure Helm

- https://hub.helm.sh/

```sh
# important because of sockets
sudo apt install socat

# install helm 3
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get-helm-3 | bash
```

## 3) Minikube development

### OpenFaas

- https://hub.helm.sh/charts/openfaas/openfaas

```sh
./k8s-cli openfaas {install|upgrade|delete|info}
```
__webui__

- http://openfaas.docker.localhost/

__Install faas-cli__

```sh
curl -sSL https://cli.openfaas.com | sudo sh
```

__Usage__

```sh
export OPENFAAS_URL=http://openfaas.docker.localhost
# login
faas-cli login -u infra --password infra
```

### Rabbitmq

- https://hub.helm.sh/charts/bitnami/rabbitmq

```sh
./k8s-cli rabbitmq {install|upgrade|delete|info}
```
__webui__

- http://rabbitmq.docker.localhost/
