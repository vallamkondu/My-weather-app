#!/bin/bash

DOCKER_VERSION=$1
BUILDAH_VERSION=$2
KUBECTL_VERSION=$3
HELM_VERSION=$4

echo "Docker Version: $DOCKER_VERSION"
echo "Buildah Version: $BUILDAH_VERSION"
echo "Kubectl Version: $KUBECTL_VERSION"
echo "Helm Version: $HELM_VERSION"


sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common curl gnupg lsb-release

# Install Docker
if [ "$DOCKER_VERSION" == "latest" ]; then
    sudo apt install -y docker.io
else
    sudo apt install -y docker-ce-cli=$DOCKER_VERSION
fi

# Install Buildah
if [ "$BUILDAH_VERSION" == "latest" ]; then
    sudo apt update && sudo apt install -y software-properties-common && sudo add-apt-repository -y ppa:projectatomic/ppa && sudo apt update
    sudo apt install -y buildah
else
    sudo apt update && sudo apt install -y software-properties-common && sudo add-apt-repository -y ppa:projectatomic/ppa && sudo apt update
    sudo apt install -y buildah=$BUILDAH_VERSION
fi

# Install Kubectl
if [ "$KUBECTL_VERSION" != "latest" ]; then
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
else
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
fi
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install Helm
if [ "$HELM_VERSION" == "latest" ]; then
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
else
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
fi
chmod +x get_helm.sh && ./get_helm.sh

# Verify installation
docker --version
buildah --version
kubectl version --client
helm version

echo "Installation Successful."
