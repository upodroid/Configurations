#!/bin/bash

kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.7/deploy/manifests/cert-manager.yaml

kubectl create namespace cert-manager
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

helm repo add jetstack https://charts.jetstack.io
helm repo update

helm install \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.7.0 \
  jetstack/cert-manager
  
sleep 20

aws_secret=`cat ~/.aws/secret.txt`
kubectl --namespace cert-manager create secret generic route53-credentials --from-literal="secret-access-key=$aws_secret"

kubectl apply -f ./issuer.yaml && kubectl apply -f ./cert.yaml

## Replicate cert to all namespaces using kubed
helm repo add appscode https://charts.appscode.com/stable/
helm repo update
helm install appscode/kubed --name kubed --namespace kube-system \
    --set apiserver.ca="$(onessl get kube-ca)" \
    --set config.clusterName=maker 

sleep 10

kubectl annotate secret borg-dev-tls -n cert-manager kubed.appscode.com/sync="app=kubed"
kubectl label namespace default app=kubed