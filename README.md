## 🚀 Azure AKS Helm Deployment Example

This project demonstrates how to deploy a simple NGINX application to **Azure Kubernetes Service (AKS)** using **Helm**.

---

### 📁 Project Structure

```
azure-aks-helm/
├── nginx-helm/           # Helm chart for NGINX or frontend
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       └── service.yaml
├── setup.sh              # Installs kubectl, Helm, Azure CLI
├── deploy.sh             # Creates AKS, resource group, deploys Helm
├── cleanup.sh            # Removes Helm release, AKS, and resource group
└── README.md
```

---

### 🧰 Stack Overview
- Cloud: Azure Kubernetes Service (AKS)
- Container Orchestration: Kubernetes
- Deployment Tool: Helm 3
- App Example: NGINX served via LoadBalancer
- CLI Tools: az, kubectl, helm

---

### ✅ Prerequisites

Before using this project:

- You have an **AKS cluster** deployed on Azure
- You know your:
  - `CLUSTER_NAME`
  - `RESOURCE_GROUP`
- Your Azure CLI is authorized

---

### 🚀 How to Deploy

1. **Install dependencies**
   ```
   chmod +x setup.sh
   ./setup.sh
   ```

2. **Run the deployment**
   ```
   chmod +x deploy.sh
   ./deploy.sh
   ```
---
### ✅ Example Output:
🌐 Waiting for external IP on service 'nginx-app-helm'...
```
NAME                TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE
nginx-app-nginx     LoadBalancer   10.0.25.145    20.120.40.10    80:32000/TCP   2m
```


🌐 Use the EXTERNAL-IP in the web-browser 

**✅Extract the EXTERNAL_IP to the bash-terminal**
```
EXTERNAL_IP=$(kubectl get svc nginx-app-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "$EXTERNAL_IP"
```
---

### 📦 Helm Chart Overview

| File | Purpose |
|------|---------|
| `Chart.yaml` | Helm chart metadata |
| `values.yaml` | Configurable values (replicas, image, service) |
| `deployment.yaml` | Kubernetes Deployment template for NGINX |
| `service.yaml` | Exposes app to the internet via LoadBalancer |

---

### 🧹 Cleanup

To uninstall the app and delete Azure resources:
   ```
   chmod +x cleanup.sh
   ./cleanup.sh
   ```

---

### 📌 Notes

- Helm allows parameterized, repeatable Kubernetes deployments.
- GitHub Codespaces makes this fully portable — zero local setup required.
- Easily adapt this chart to deploy other services (e.g., React or Node.js apps).

---

### ✍️ Author: *Georges Bou Ghantous*
*Built for AKS deployment demonstrations with GitHub Codespaces, Helm, and Kubernetes 💙*