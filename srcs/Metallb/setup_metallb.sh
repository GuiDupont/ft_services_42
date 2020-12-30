
sudo kubectl apply -f load-balancer-manifest.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
sudo kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
sudo kubectl apply -f config_metallb.yaml


###Query the state of service load-balancer-service###

#kubectl get service load-balancer-service -o wide

###Query the state of deploy###

#kubectl get deploy controller -n metallb-system -o wide