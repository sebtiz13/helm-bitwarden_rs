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
helm init --wait
```

## Usage
The minimal deployment using all default values;
```
DOMAIN=bitwarden.yourdomain.com
helm install --wait --set "ingress.hosts={$DOMAIN},ingress.tls[0].hosts={$DOMAIN},ingress.tls[0].secretName=bitwarden-tls-secret" .
```
This will setup `bitwarden_rs` with a persistent storage and a backup volume, with backups being shot at 3:00 every night.

HTTPS certificates will automatically be generated using [Let's Encrypt](https://letsencrypt.org/) and HTTPS will be terminated at the Ingress Controller.
*This assumes that a [Kubernetes NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx) is running, and that [cert-manager](https://github.com/jetstack/cert-manager) has been set up and configured. See [here (ingress)](https://github.com/icicimov/kubernetes-bitwarden_rs#nginx-proxy) and [here (cert-manager)](https://github.com/icicimov/kubernetes-bitwarden_rs#lets-encrypt) for examples on how to set either up.*

## Configuration
Several konfiguration options are available, they can be seen in `values.yaml`, and override like above using `--set` or using `--values`, see more [here](https://docs.helm.sh/helm/#helm-install).

## Screenshot

![bitwarden_rs](bitwarden.png "bitwarden_rs")
