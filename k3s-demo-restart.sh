#! /bin/bash

# restart the k3s systemd service

echo "$(date +'%F %H:%M:%S') Status: Restarting k3s....."

sudo systemctl restart k3s.service 2>&1 > /tmp/restart-logs

if [[ "${?}"  -ne 0 ]]
then
    echo ‘Service failed to start, please see restart-logs’
      exit 1
fi

echo "Starting K3s Pod/Deployments...... "

# Please verify if you have access to this file or you can skip below if running as root.
sudo chmod 644 /etc/rancher/k3s/k3s.yaml 2>&1 > /dev/null

kubectl wait deployment -n kube-system coredns --for condition=Available=True --timeout=90s
kubectl wait deployment -n kube-system local-path-provisioner --for condition=Available=True --timeout=90s
kubectl wait deployment -n kube-system metrics-server --for condition=Available=True --timeout=90s
kubectl wait deployment -n kube-system traefik --for condition=Available=True --timeout=90s

echo "$(date +'%F %H:%M:%S') Status: K3s is ready to use!"
