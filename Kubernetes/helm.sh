source vars.sh
rm -rf ~/.kube || true
rm -rf ~/.helm || true

gcloud container clusters get-credentials $CLUSTER_NAME

# Install helm + login with project owner or container-admin SA
# More Args  https://github.com/helm/charts/tree/master/stable/nginx-ingress

# Avoids RBAC Errors
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user=$(gcloud config get-value core/account)
  
sleep 5
while true; do
    read -p "Are you ready to install Tiller on the Cluster? " yn
    case $yn in
        [Yy]* ) kubectl apply -f tiller.yaml
        helm init --service-account tiller --wait ;
        break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

helm install --name nginx-ingress stable/nginx-ingress \
  --values nginx-ingress.yaml

bash ssl.sh