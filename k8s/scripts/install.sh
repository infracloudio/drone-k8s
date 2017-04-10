#!/bin/bash

#
# Install docker
#
sudo apt-get update
sudo apt-get install -y \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce

cd /tmp;
#
# Install kubectl
#
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

#
# Install Helm
#

wget https://kubernetes-helm.storage.googleapis.com/helm-v2.2.2-linux-amd64.tar.gz
tar xvf helm-v2.2.2-linux-amd64.tar.gz

chmod 755 linux-amd64/helm kubectl
mv linux-amd64/helm kubectl /usr/local/bin/;


#
# Install drone CLI
#

curl http://downloads.drone.io/release/linux/amd64/drone.tar.gz | tar zx
sudo install -t /usr/local/bin drone

echo "=========== Docker , Kubectl, Helm and drone have been installed =============";

# Command to get cluster info
# gcloud container clusters get-credentials development-systems \
#     --zone us-west1-b --project that-big-universe