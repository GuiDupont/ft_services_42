# https://kubernetes.io/docs/tutorials/hello-minikube/

#!/usr/bin/env bash

#What you'll need:
#2 CPUs or more
#2GB of free memory
#20GB of free disk space
#Internet connection

#We update the environnement
sudo apt-get update -y


#We install minikube, using https://minikube.sigs.k8s.io/docs/start/#x86
#we assume that we are on Linux.

sudo apt-get install -y rpm

sudo apt-get install -y libc.so



curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
sudo rpm -ivh minikube-latest.x86_64.rpm



kubectl delete --all secret
env var CHANGE_MINIKUBE_NONE_USER=true


if ! which conntrack &>/dev/null; then
	sudo apt-get install -y conntrack
fi


sudo service nginx stop

sudo systemctl enable docker.service
sudo minikube start
#sudo minikube start --driver=none
# I took away --driver=none to see


#LoadBalancer
echo "Installing MetalLB..."


kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

sudo kubectl apply -f srcs/Metallb/load-balancer-manifest.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

sudo kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
sudo kubectl apply -f srcs/Metallb/metallb_config.yaml


#NGINX
docker build -t nginx_image srcs/nginx
sudo kubectl apply -f srcs/nginx/nginx_deployment.yaml
