# ft_services_42

This project aims to setup a kubernetes cluster based on minikube and running the following applications:
- mysql db
- wordpress
- phpmyadmin
- VSFTPD
- MetalLB
- Influxdb (using telegraf)
- Grafana
Except MetalLB, all are running on pods based on Alpine. When a pod crashes, its data are preseved and the pod is automatically relaunch, 
thanks respectively to volume persistence and livenessprob Kubernetes features.

For questions, contact me at gdupont@student.42.fr
