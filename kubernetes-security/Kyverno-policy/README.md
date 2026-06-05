## What is Kyverno?

Kyverno is a **Kubernetes-native policy engine** that helps you **validate, mutate, generate, and enforce policies** on Kubernetes resources.

Unlike tools that require learning a separate policy language, Kyverno policies are written in **YAML**, making them easy for Kubernetes administrators and DevOps engineers to understand.

Think of Kyverno as a **security guard and compliance checker** for your Kubernetes cluster.

---

## Why Do We Need Kyverno?

In a Kubernetes cluster, developers can create resources such as:

```yaml
Pod
Deployment
Service
Ingress
ConfigMap
Secret
```

Without governance, developers may:

* Deploy containers as root
* Use latest image tags
* Skip resource limits
* Expose services publicly
* Deploy from unapproved registries

These can lead to security, compliance, and operational issues.

Kyverno automatically checks and enforces your organization's rules.

---

## How Kyverno Works

When a user creates a resource:

```text
kubectl apply -f deployment.yaml
```

The request goes through:

```text
User
  ↓
Kubernetes API Server
  ↓
Kyverno Admission Controller
  ↓
Allowed or Rejected
```

Kyverno examines the resource before it is created.

---

## Main Capabilities of Kyverno

### 1. Validate Policies

Ensures resources follow rules.

### Example:

Block containers running as root.

```yaml
validate:
  message: "Containers cannot run as root"
```

If someone deploys:

```yaml
securityContext:
  runAsUser: 0
```

Kyverno rejects it.

---

### 2. Mutate Policies

Automatically modify resources.

### Example:

Add labels automatically.

Developer creates:

```yaml
metadata:
  name: app1
```

Kyverno adds:

```yaml
labels:
  environment: production
```

No manual effort required.

---

### 3. Generate Policies

Automatically create resources.

### Example:

Whenever a namespace is created:

```yaml
kubectl create ns finance
```

Kyverno automatically generates:

```text
NetworkPolicy
ResourceQuota
LimitRange
```

for that namespace.

---

### 4. Verify Images

Ensure images come from trusted registries.

Allow:

```text
acr.company.com/*
```

Block:

```text
docker.io/randomuser/*
```

This prevents unapproved images from being deployed.

---

## Real-World AKS Examples

In an Azure Kubernetes Service environment, Kyverno is commonly used to enforce:

### Security

Require:

```yaml
runAsNonRoot: true
```

Block privileged containers:

```yaml
privileged: true
```

---

### Resource Limits

Require every pod to have:

```yaml
resources:
  requests:
  limits:
```

Prevents resource starvation.

---

### Approved Container Registries

Allow only:

```text
Azure Container Registry (ACR)
```

Reject images from unknown registries.

---

### Mandatory Labels

Require:

```yaml
team
owner
environment
costcenter
```

Useful for governance and cost tracking.

---

## Example Policy

Only allow images from company ACR:

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: allowed-registry
spec:
  validationFailureAction: Enforce
  rules:
  - name: check-registry
    match:
      any:
      - resources:
          kinds:
          - Pod
    validate:
      message: "Only ACR images are allowed"
      pattern:
        spec:
          containers:
          - image: "myacr.azurecr.io/*"
```

---

## Kyverno vs OPA Gatekeeper

| Feature                  | Kyverno | OPA Gatekeeper   |
| ------------------------ | ------- | ---------------- |
| Language                 | YAML    | Rego             |
| Learning Curve           | Easy    | Moderate to Hard |
| Mutation Support         | Yes     | Limited          |
| Generate Resources       | Yes     | No               |
| Kubernetes Native        | Yes     | Yes              |
| Popular for DevOps Teams | Very    | Moderate         |

Many teams choose Kyverno because it uses standard Kubernetes YAML.

---

## Typical Enterprise Use Cases

### Security

* No root containers
* No privileged containers
* Approved images only

### Compliance

* PCI-DSS
* HIPAA
* SOC2

### Governance

* Enforce labels
* Resource quotas
* Namespace standards

### Cost Control

* Require CPU and memory limits

---

## Example Before and After

Developer deploys:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
```

Kyverno mutates it to:

```yaml
metadata:
  name: app
  labels:
    environment: prod
```

and validates:

```yaml
resources:
  limits:
    memory: 512Mi
```

If missing, deployment is rejected.

---

## Benefits of Kyverno

✅ Improves Kubernetes security
✅ Enforces company standards automatically
✅ Prevents misconfigurations before deployment
✅ Supports compliance requirements
✅ Uses familiar Kubernetes YAML
✅ Works seamlessly with AKS, EKS, and GKE

---

### Simple Analogy

Imagine Kubernetes is a building.

* **Kubernetes API Server** = Building entrance
* **Developers** = Visitors
* **Kyverno** = Security guard

The security guard checks:

* Is the visitor authorized?
* Are they carrying prohibited items?
* Do they follow company rules?

If not, entry is denied.

