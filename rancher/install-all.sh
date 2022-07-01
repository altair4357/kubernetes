#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 clusterfile hostname replicas" >&2
    echo "Example: $0 cluster.yml host.domain 3" >&2
    exit 1
fi

SET_CLUSTER_FILE=$1
SET_HOSTNAME=$2
SET_REPLICAS=$3

set -x

if [ ! -f /usr/bin/docker ]; then
    echo "Run this script after running install-docker.sh." >&2
    exit 1
fi

SCRIPT_DIR="$(cd $(dirname $0) && pwd)"

$SCRIPT_DIR/install-kubectl.sh
$SCRIPT_DIR/install-helm.sh
$SCRIPT_DIR/install-rke.sh
$SCRIPT_DIR/rke-up.sh $SET_CLUSTER_FILE
$SCRIPT_DIR/install-rancher.sh $SET_HOSTNAME $SET_REPLICAS

