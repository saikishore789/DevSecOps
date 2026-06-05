## What is Calico in Kubernetes?

**Calico** is a popular **Container Network Interface (CNI)** and **network security solution** for Kubernetes. It provides:

1. **Networking** – Enables communication between pods.
2. **Network Policies** – Controls which pods can communicate with each other.
3. **Traffic Filtering** – Enforces security rules at the network layer.
4. **Routing** – Efficiently routes traffic between pods and nodes.

Think of Calico as a **virtual firewall and networking layer** for your Kubernetes cluster.

---

## Why is Calico Used in AKS?

In Azure Kubernetes Service, Calico is primarily used for **network policy enforcement**.

### Without Calico

By default, any pod can talk to any other pod in the cluster:

```text
Frontend Pod  ---> Backend Pod
Frontend Pod  ---> Database Pod
Any Pod       ---> Any Pod
```

This can be a security risk.

---

### With Calico

You can restrict communication:

```text
Frontend Pod  ---> Backend Pod    ✅ Allowed
Frontend Pod  ---> Database Pod   ❌ Blocked
Unknown Pod   ---> Database Pod   ❌ Blocked
```

Only approved traffic is allowed.

---

## Example Network Policy

Allow only frontend pods to access backend pods:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend
spec:
  podSelector:
    matchLabels:
      app: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
```

Calico enforces this rule.

---

## Common AKS Use Cases

### 1. Microservices Security

```text
Frontend
    ↓
Backend
    ↓
Database
```

Calico ensures:

* Frontend cannot directly access Database.
* Only Backend can access Database.

---

### 2. Regulatory Compliance

For environments requiring:

* PCI-DSS
* HIPAA
* SOC2

Network segmentation is often required. Calico helps implement it.

---

### 3. Multi-Team Clusters

Different teams may share the same AKS cluster.

```text
Team A Namespace
Team B Namespace
Team C Namespace
```

Calico can prevent cross-team communication unless explicitly allowed.

---

## How to Check if Calico is Enabled

### Check Network Policy Provider

```bash
az aks show \
  --resource-group <rg-name> \
  --name <aks-name> \
  --query networkProfile.networkPolicy
```

Example output:

```json
"calico"
```

---

### Check Calico Pods

```bash
kubectl get pods -A | grep calico
```

You may see pods such as:

```text
calico-node
calico-kube-controllers
```

---

## Azure CNI vs Calico

Many people confuse these:

| Component                | Purpose                                 |
| ------------------------ | --------------------------------------- |
| Azure CNI                | Assigns IPs and provides pod networking |
| Calico                   | Applies network security policies       |
| Kubernetes NetworkPolicy | Defines the rules                       |
| Calico                   | Enforces the rules                      |

A common AKS setup is:

```text
Azure CNI + Calico
```

where:

* Azure CNI handles networking.
* Calico handles security policies.

---

## Example Real-World Scenario

Suppose you have:

```text
Namespace: production

Pods:
- web-app
- api-app
- sql-app
```

Requirement:

* Web → API ✅
* API → SQL ✅
* Web → SQL ❌

Calico enforces these restrictions through network policies.

---

## Benefits of Calico

✅ Micro-segmentation between applications
✅ Improved security posture
✅ Zero-trust networking approach
✅ Compliance support
✅ Fine-grained traffic control
✅ Works well with AKS and Azure CNI

---

### Quick Summary

**Calico in AKS is mainly used to enforce Kubernetes Network Policies.** It acts as a network security layer that controls which pods, namespaces, and services can communicate with each other, helping secure applications running in the cluster.
