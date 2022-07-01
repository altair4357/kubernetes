#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 cluster_file" >&2
    echo "Example: $0 cluster.yml" >&2
    exit 1
fi

set -x

CLUSTER_YML_FILE=$1

if [ ! -f $HOME/.ssh/id_rsa ]; then
    ssh-keygen -t rsa
    cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
fi

rke up --config $CLUSTER_YML_FILE
if [ ! -d ~/.kube ]; then
    mkdir ~/.kube
fi
cp kube_config_$CLUSTER_YML_FILE ~/.kube/config
