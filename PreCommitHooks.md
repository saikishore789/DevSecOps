Great follow-up — **pre-commit hooks** are one of Git’s best quality-control features 👍
They help catch mistakes **before bad code ever enters your repository**.

Let’s walk through it clearly and practically.

---

## 🪝 What is a pre-commit hook?

A **pre-commit hook** is a script that runs **automatically before a commit is created**.

👉 Git pauses the commit
👉 Runs your checks
👉 If checks fail → commit is blocked
👉 If checks pass → commit goes through

Think of it as a **gatekeeper for your code** 🚦

---

## 🎯 Why do we use pre-commit hooks?

### ✅ Prevent broken code

Stop commits if:

* Tests fail
* Lint errors exist
* Formatting is wrong

### 🔐 Prevent secrets leakage

Block commits containing:

* passwords
* API keys
* certificates

### 📏 Enforce standards

Ensure:

* proper formatting
* naming conventions
* clean code

---

## 📦 Common things checked in pre-commit

| Check      | Example         |
| ---------- | --------------- |
| Linting    | ESLint, flake8  |
| Formatting | Prettier, Black |
| Tests      | unit tests      |
| Security   | secret scanners |
| File rules | no large files  |

---

## 🔁 Simple flow

```
git commit
   ↓
pre-commit hook runs
   ↓
❌ fails → commit blocked
✅ passes → commit saved
```

---

## ✍️ Example (simple)

### Pre-commit script that blocks TODOs:

```bash
#!/bin/sh
if grep -R "TODO" .; then
  echo "Remove TODOs before commit!"
  exit 1
fi
```

👉 If TODO exists → commit fails

---

## 🧰 Popular pre-commit framework (recommended)

Most teams use **pre-commit** tool (Python-based but works for all languages)

Example config:

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    hooks:
      - id: trailing-whitespace
      - id: check-yaml
```

Runs automatically every commit.

---

## 🧠 Real-world DevOps example (like in CI/CD)

Before pushing code:

✔ Code formatted
✔ No secrets
✔ Tests pass

This reduces:
❌ pipeline failures
❌ production bugs
❌ rollback incidents

---

## 📌 Difference from CI pipeline

| Pre-commit hook      | CI/CD                |
| -------------------- | -------------------- |
| Runs locally         | Runs on server       |
| Instant feedback     | Slower               |
| Prevents bad commits | Validates final code |
| Developer side       | Platform side        |

👉 Best practice: **use both**

---

### ✅ In short:

**Pre-commit hooks = automatic quality checks before code is committed**

They:
✔ save time
✔ avoid bugs
✔ enforce standards
✔ protect security

---