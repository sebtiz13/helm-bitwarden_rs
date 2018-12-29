# Kubernetes deployment via Helm
Helm chart to deploy a fully functional and secure [`bitwarden_rs`](https://github.com/dani-garcia/bitwarden_rs) application in [Kubernetes](https://kubernetes.io/).

## Requirements
Requires a Kubernetes cluster setup, with dns, storage and [Helm and Tiller](https://docs.helm.sh/) configured.

A cluster for testing, can be setup (on Ubuntu) using:
```
snap install microk8s --classic
microk8s.start
microk8s.status --wait-ready
microk8s.enable dns dashboard
microk8s.status --wait-ready
snap install helm --classic
helm init
```

## Usage
The minimal deployment using all default values;
```
DOMAIN=bitwarden.yourdomain.com
helm install --set "ingress.hosts={$DOMAIN},ingress.tls[0].hosts={$DOMAIN},ingress.tls[0].secretName=bitwarden-tls-secret" .
```

## Screenshot

![bitwarden_rs](bitwarden.png "bitwarden_rs")
