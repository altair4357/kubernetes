#!/bin/bash

set -x

sudo apt update
sudo apt install -y docker.io
sudo usermod -a -G docker $USER
newgrp docker

