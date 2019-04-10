#!/bin/bash
echo "Navigate to ~/k8s-init and tweak the vars.sh as needed"
mkdir -p ~/k8s-init
curl -O https://raw.githubusercontent.com/upodroid/Configurations/master/Kubernetes/cert.yaml
curl -O https://raw.githubusercontent.com/upodroid/Configurations/master/Kubernetes/helm.sh
curl -O https://raw.githubusercontent.com/upodroid/Configurations/master/Kubernetes/vars.sh
curl -O https://raw.githubusercontent.com/upodroid/Configurations/master/Kubernetes/ssl.sh
curl -O https://raw.githubusercontent.com/upodroid/Configurations/master/Kubernetes/issuer.yaml