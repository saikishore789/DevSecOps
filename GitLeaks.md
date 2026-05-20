## 🚨 What is Gitleaks?

**Gitleaks is a security scanning tool** that detects sensitive information in your code such as:

✔ API keys
✔ passwords
✔ tokens
✔ AWS secrets
✔ private keys
✔ database credentials

It scans:

* source code
* commit history
* staged files before commit

---

### 🔍 Example of what Gitleaks catches

```env
AWS_SECRET_ACCESS_KEY=AKIA********
DB_PASSWORD=admin123
```

👉 Gitleaks immediately flags this as a secret.

---

## 🪝 How is Gitleaks related to pre-commit hooks?

Pre-commit hooks are **when** checks run
Gitleaks is **what** does the secret scanning

### Together they work like this:

```
git commit
   ↓
pre-commit hook triggers
   ↓
Gitleaks scans staged files
   ↓
❌ secret found → commit blocked
✅ clean → commit allowed
```

👉 This prevents security leaks before code is pushed

---

## 🎯 Why teams use Gitleaks in pre-commit

### Without Gitleaks:

❌ Secrets get committed
❌ Repo gets compromised
❌ Must rotate credentials

### With Gitleaks:

✅ Zero secret leaks
✅ Automatic protection
✅ Dev doesn’t need to remember

---

## 🧩 Simple setup idea (common in DevOps)

In `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    hooks:
      - id: gitleaks
```

Now every commit is scanned automatically.

---

## 📊 Real-world DevOps flow

| Stage         | Tool                         |
| ------------- | ---------------------------- |
| Before commit | Gitleaks via pre-commit hook |
| After push    | GitHub/GitLab security scans |
| CI pipeline   | SAST + secret scanners       |

Pre-commit = first defense line 🛡️

---

## 🧠 Easy way to remember

**Pre-commit hook = gate**
**Gitleaks = security guard at the gate**

No secret passes 🚫

---

## ⚠️ Bonus tip (important in interviews)

Say:

> “We use Gitleaks in pre-commit hooks to prevent credentials from being committed and also scan repositories in CI/CD for historical leaks.”

That’s exactly what real DevOps teams do 👍

---

### ✅ In one line:

**Gitleaks is a secret scanner, and pre-commit hooks run it automatically before every Git commit to block sensitive data.**
