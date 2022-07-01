#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 hostname replicas" >&2
    echo "Example: $0 host.domain 3" >&2
    exit 1
fi

set -x

SET_HOSTNAME=$1
SET_REPLICAS=$2

# Add the Helm Chart Repository
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

# Create a Namespace for Rancher
kubectl create namespace cattle-system

# Install cert-manager
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.5.1/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.5.1
kubectl -n cert-manager rollout status deploy/cert-manager
kubectl -n cert-manager get deploy cert-manager

# Install Rancher with Helm and Certificate Option
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=$SET_HOSTNAME \
  --set bootstrapPassword=admin \
  --set replicas=$SET_REPLICAS
kubectl -n cattle-system rollout status deploy/rancher
kubectl -n cattle-system get deploy rancher

