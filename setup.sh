# if there are issues with permissions do the following command
#sudo usermod -aG docker user42; newgrp docker






#minikube delete && minikube start --vm-driver=docker

#MAKING SURE THE DOCKER IMAGES WILL BE IN THE MINIKUBE ENVIRONMENT
eval $(minikube docker-env)

##LoadBalancer MetalLB##
echo "Installing MetalLB..."

# # see what changes would be made, returns nonzero returncode if different
# kubectl get configmap kube-proxy -n kube-system -o yaml | \
# sed -e "s/strictARP: false/strictARP: true/" | \
# kubectl diff -f - -n kube-system

# # actually apply the changes, returns nonzero returncode on errors only
# kubectl get configmap kube-proxy -n kube-system -o yaml | \
# sed -e "s/strictARP: false/strictARP: true/" | \
# kubectl apply -f - -n kube-system


kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/Metallb/metallb_config.yaml


#CREATING MY OWN IMAGES
docker build -t my_nginx srcs/nginx
docker build -t my_wordpress srcs/wordpress
docker build -t my_phpmyadmin srcs/phpmyadmin
docker build -t my_mysql srcs/mysql

##NGINX##
kubectl apply -f srcs/nginx/nginx.yaml

##WORDPRESS##
kubectl apply -f srcs/wordpress/wordpress.yaml

##PHPMYADMIN##
kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml

##MYSQL##
kubectl apply -f srcs/mysql/mysql.yaml
