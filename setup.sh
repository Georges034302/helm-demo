#!/bin/bash

set -e

echo "🔧 Installing dependencies for AKS + Helm in GitHub Codespaces..."

# Update system packages only if needed for package installation
NEED_APT_UPDATE=false

if ! command -v jq &> /dev/null; then
  NEED_APT_UPDATE=true
fi

if [ "$NEED_APT_UPDATE" = true ]; then
  echo "🔄 Updating system package lists..."
  sudo apt-get update
fi

# Install kubectl
echo "📦 Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install Azure CLI if not present
if ! command -v az &> /dev/null; then
  echo "📦 Installing Azure CLI..."
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
  echo "✅ Azure CLI already installed."
fi

# Install Helm if not present
if ! command -v helm &> /dev/null; then
  echo "📦 Installing Helm..."
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
  echo "✅ Helm already installed."
fi

# Install jq if not present
# jq is a lightweight and flexible command-line JSON processor
if ! command -v jq &> /dev/null; then
  echo "📦 Installing jq (command-line JSON processor)..."
  sudo apt-get install -y jq
else
  echo "✅ jq already installed."
fi

# Log in and register the AKS provider
if ! az account show &> /dev/null; then
  echo "🔑 Logging in to Azure using device code..."
  az login --use-device-code
else
  echo "✅ Already logged in to Azure CLI."
fi

echo "🔗 Registering Microsoft.ContainerService provider..."
az provider register --namespace Microsoft.ContainerService

echo "⏳ Waiting for provider registration..."
az provider show --namespace Microsoft.ContainerService --query "registrationState"

echo "✅ Tools installed and provider registered: kubectl, az, helm, jq"