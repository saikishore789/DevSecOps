# RBAC (Role-Based Access Control)

## What is RBAC?

RBAC controls **who can do what** in a Kubernetes cluster.

RBAC answers:

* Who? → User / ServiceAccount
* What? → Verbs (get, list, create, delete)
* On what? → Resources (pods, secrets, deployments)
* Where? → Namespace or cluster

---

## RBAC Components

* **Role**: Permissions within a namespace
* **ClusterRole**: Permissions cluster-wide
* **RoleBinding**: Binds Role to a subject
* **ClusterRoleBinding**: Binds ClusterRole to a subject

Create a Role in `payments` namespace:

```
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: payments
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
EOF
```

## Hands-On: Create a ServiceAccount

```
kubectl create serviceaccount payments-user -n payments
```

---

## Hands-On: Bind Role to ServiceAccount

```
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods-binding
  namespace: payments
subjects:
- kind: ServiceAccount
  name: payments-user
  namespace: payments
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
EOF
```

---

## Verification (Very Important)

Check permissions:

```
kubectl auth can-i list pods \
  --as=system:serviceaccount:payments:payments-user \
  -n payments
```

Expected output:

```
yes
```

Try deleting pods:

```
kubectl auth can-i delete pods \
  --as=system:serviceaccount:dev:dev-user \
  -n payments
```

Expected output:

```
no
```