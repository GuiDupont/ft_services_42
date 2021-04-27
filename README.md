# ft_services_42

This project aims to setup a kubernetes cluster based on minikube and running the following applications:
- mysql db
- wordpress
- phpmyadmin
- VSFTPD
- MetalLB
- Influxdb (using telegraf)
- Grafana

Except MetalLB, all are running on pods based on Alpine. When a pod crashes, its data are preserved and a new pod is automatically relaunch, 
using respectively volume persistence feature and livenessprob feature.

For questions, contact me at gdupont@student.42.fr
