# if there are issues with permissions do the following command
#sudo usermod -aG docker user42; newgrp docker


minikube delete
minikube start --vm-driver=docker
clear
#MAKING SURE THE DOCKER IMAGES WILL BE IN THE MINIKUBE ENVIRONMENT
eval $(minikube docker-env)



##LoadBalancer MetalLB##
echo "Installing MetalLB..."

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/Metallb/metallb_config.yaml


# CREATING IMAGES
# docker build -t my_nginx srcs/nginx
# docker build -t my_wordpress srcs/wordpress
# docker build -t my_phpmyadmin srcs/phpmyadmin
# docker build -t my_mysql srcs/mysql
# docker build -t my_ftps srcs/ftps
# docker build -t my_influxdb srcs/influxdb
docker build -t my_grafana srcs/grafana

##Persistent Volumes##
mkdir /home/user42/kube_mysql/ /home/user42/kube_influxdb/ 
kubectl apply -f srcs/PersistentVolume/PV.yaml

##NGINX##
kubectl apply -f srcs/nginx/nginx.yaml

##WORDPRESS##
kubectl apply -f srcs/wordpress/wordpress.yaml

##PHPMYADMIN##
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml

##MYSQL##
kubectl apply -f srcs/mysql/mysql.yaml

##FTPS##
kubectl apply -f srcs/ftps/ftps.yaml

##INFLUXDB + TELEGRAF##
kubectl apply -f srcs/influxdb/influxdb.yaml

##GRAFANA##
kubectl apply -f srcs/grafana/grafana.yaml

clear
#minikube dashboard