# Infrastructure

!!!!! __YOU NEED TO BE ON ROOT PROJECT DIRECTORY__ !!!!!

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

## warning: addons to enable
minikube addons enable ingress
minikube addons enable ingress-dns

minikube addons list

kubectl expose deployment nginx-ingress-controller -n kube-system --target-port=80 --type=NodePort
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

# get helm (only one time)
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get-helm-3 | bash
```

## 3) Minikube development

### OpenFaas

- https://hub.helm.sh/charts/openfaas/openfaas

```sh
# start
./k8s-cli openfaas start
# stop
./k8s-cli openfaas stop
```

### Rabbitmq

- https://hub.helm.sh/charts/bitnami/rabbitmq

```sh
# start
./k8s-cli rabbitmq start
# stop
./k8s-cli rabbitmq stop

https://rabbitmq.docker.localhost/
```
