#!/bin/bash

echo "--------------------"
echo "Component: $1"
echo "Method: $2"
echo "--------------------"

setup () {
  helm repo add openfaas https://openfaas.github.io/faas-netes
  helm repo add bitnami https://charts.bitnami.com
}

openfaas () {
  case "$1" in
    info)
      kubectl --namespace=openfaas get all
      ;;
    install)
      setup
      kubectl apply -f kubernetes/openfaas/namespaces.yaml
      kubectl --namespace openfaas create secret generic basic-auth --from-literal=basic-auth-user=infra --from-literal=basic-auth-password=infra
      helm install openfaas openfaas/openfaas --values kubernetes/openfaas/values.yaml --namespace openfaas
      kubectl apply -f kubernetes/openfaas/service.yaml --namespace openfaas
      kubectl apply -f kubernetes/openfaas/ingress.yaml --namespace openfaas
      nslookup openfaas.docker.localhost $(minikube ip)
      ;;
    upgrade)
      setup
      helm upgrade openfaas openfaas/openfaas --values kubernetes/openfaas/values.yaml --namespace openfaas
      ;;
    delete)
      helm delete openfaas
      kubectl delete --namespace openfaas secret basic-auth
      kubectl delete -f kubernetes/openfaas/service.yaml --namespace openfaas
      kubectl delete -f kubernetes/openfaas/ingress.yaml --namespace openfaas
      kubectl delete -f kubernetes/openfaas/namespaces.yaml
      ;;
    *)
      echo $"Usage: {install|upgrade|delete|info}"
      exit 1
  esac
}

rabbitmq () {
  case "$1" in
    info)
      kubectl --namespace=rabbitmq get all
      ;;
    install)
      setup
      kubectl apply -f kubernetes/rabbitmq/namespaces.yaml
      helm install rabbitmq bitnami/rabbitmq --values kubernetes/rabbitmq/values.yaml --namespace rabbitmq
      kubectl apply -f kubernetes/rabbitmq/service.yaml --namespace rabbitmq
      kubectl apply -f kubernetes/rabbitmq/ingress.yaml --namespace rabbitmq
      nslookup rabbitmq.docker.localhost $(minikube ip)
      ;;
    upgrade)
      helm upgrade rabbitmq bitnami/rabbitmq --values kubernetes/rabbitmq/values.yaml --namespace rabbitmq
      ;;
    delete)
      helm delete rabbitmq
      kubectl delete -f kubernetes/rabbitmq/service.yaml --namespace rabbitmq
      kubectl delete -f kubernetes/rabbitmq/ingress.yaml --namespace rabbitmq
      kubectl delete -f kubernetes/rabbitmq/namespaces.yaml
      ;;
    *)
      echo $"Usage: {install|upgrade|delete|info}"
      exit 1
  esac
}

case "$1" in

  setup)
    setup
    ;;

  all)
    openfaas $2
    rabbitmq $2
    ;;

  openfaas)
    openfaas $2
    ;;

  rabbitmq)
    rabbitmq $2
    ;;

  *)
    echo $"Usage: {all:rabbitmq|openfaas} {install|upgrade|delete|info}"
    exit 1

esac
