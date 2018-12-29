#!/bin/bash

microk8s.kubectl port-forward $POD_NAME 31111:80 &
until [ curl -sI localhost:31111 | grep "200 OK" ]; do
   echo "Waiting for port-forward...";
done

curl -s localhost:31111 | grep "Bitwarden Web Vault"
kill $(jobs -p)
