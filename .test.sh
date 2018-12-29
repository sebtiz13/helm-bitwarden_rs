#!/bin/bash

microk8s.kubectl port-forward $POD_NAME 31111:80 &
printf "Waiting for port-forward.";
until $(curl --output /dev/null --silent --head --fail localhost:31111); do
   printf '.'
   sleep 1
done

curl -s localhost:31111 | grep "Bitwarden Web Vault"
kill $(jobs -p)
