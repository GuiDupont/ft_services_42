#!/usr/bin/env bash

#What you'll need:
#2 CPUs or more
#2GB of free memory
#20GB of free disk space
#Internet connection

# If we want to launch minikube with --driver=none we must install conntrack
if ! which conntrack &>/dev/null; then
	sudo apt-get install -y conntrack
fi

# Stopping nginx is necessary to avoid potential future issues
sudo service nginx stop

# sudo systemctl enable docker.service

# Since we are on a VM we launch minikube with no driver selected
echo "Launching minikube..."
sudo minikube start --driver=none

##LoadBalancer MetalLB##
echo "Installing MetalLB..."

sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
sudo kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

sudo kubectl apply -f srcs/Metallb/metallb_config.yaml



##NGINX##
# docker build -t nginx_image srcs/nginx

# sudo kubectl apply -f srcs/nginx/nginx_deployment.yaml
