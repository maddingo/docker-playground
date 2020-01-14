# PlantUML with Kubernetes and Ingress

This guide assumes you have a cluster up and running, e.g. microk8s.

1. microk8s.enable dns storage registry dashboard ingress
1. `token=$(microk8s.kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)`\
   `microk8s.kubectl -n kube-system describe secret $token`
