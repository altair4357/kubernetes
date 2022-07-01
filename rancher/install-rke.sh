#!/bin/bash

set -x

wget https://github.com/rancher/rke/releases/download/v1.3.6/rke_linux-amd64
mv rke_linux-amd64 rke
chmod +x rke
sudo mv rke /usr/bin
rke --version

