# 📘 Professional n8n Manual — AutomaxDigital

> **Brand:** AutomaxDigital
> **Stack:** n8n + FFmpeg + EasyPanel + GHCR + Postgres + Redis (Queue Mode)

This document is the **official AutomaxDigital guide** for running **n8n in production** with safety, predictability, and fast rollback.

---

## 📐 Reference Architecture (AutomaxDigital)

* **n8n-editor** → UI / Admin panel
* **n8n-webhook** → Webhook receiver
* **n8n-worker** → Queue executions
* **Postgres** → Single persistent database
* **Redis** → Queue (Bull / Queue Mode)

AutomaxDigital base image:

```bash
ghcr.io/pedroroms/n8n-ffmpeg/n8n-ffmpeg:<TAG>
```

---

# 🔁 Update Checklist (5 minutes)

> **Goal:** update n8n safely without breaking production.

## 1️⃣ Pre-check (1 min)

* [ ] Production is stable
* [ ] Current version noted (e.g. `1.121.3`)
* [ ] New n8n version is **stable** (not beta)

---

## 2️⃣ Build new image (2 min)

1. Update the `Dockerfile`:

```dockerfile
FROM n8nio/n8n:1.121.3
```

Change to:

```dockerfile
FROM n8nio/n8n:1.122.0
```

2. Commit:

```text
chore(automaxdigital): update n8n to 1.122.0
```

3. Create a **Release**:

```text
v1.122.0
```

4. Wait for GitHub Actions to turn **green**.

---

## 3️⃣ Update EasyPanel services (1 min)

For **all n8n services**:

* `n8n-editor`
* `n8n-webhook`
* `n8n-worker`

Set image:

```bash
ghcr.io/pedroroms/n8n-ffmpeg/n8n-ffmpeg:1.122.0
```

---

## 4️⃣ Controlled restart order (1 min)

Restart in this order:

1. Postgres
2. Redis
3. n8n-editor
4. n8n-webhook
5. n8n-worker

---

## 5️⃣ Post-update validation

* [ ] Editor loads correctly
* [ ] Login works
* [ ] Test webhook responds
* [ ] Executions succeed

If all OK → update completed ✅

---

# ⏪ Emergency Rollback Checklist (1 page)

> **Use if something breaks after an update.**

## 🔥 ROLLBACK IN 3 STEPS

### 1️⃣ Revert image (all n8n services)

```bash
ghcr.io/pedroroms/n8n-ffmpeg/n8n-ffmpeg:1.121.3
```

### 2️⃣ Restart (mandatory order)

1. Postgres
2. Redis
3. n8n-editor
4. n8n-webhook
5. n8n-worker

### 3️⃣ Minimal validation

* Open editor
* Run a simple workflow
* Call a test webhook

⏱️ Average time: **2–5 minutes**

---

# 🧠 Controlled Manual Updates (AutomaxDigital Standard)

## ❌ Never use in production

* `:latest`
* Auto-updates without approval
* Watchtower

## ✅ Correct update flow

```text
New n8n version
 → Update Dockerfile
 → Create AutomaxDigital image release
 → Update tag in EasyPanel
 → Controlled restart
```

Benefits:

* Predictability
* Fast rollback
* Zero surprises

---

# 📄 Official Repository README.md

````md
# n8n-ffmpeg — AutomaxDigital

Official **AutomaxDigital Docker image** for running **n8n with FFmpeg** in production.

---

## ✨ Features
- Official n8n
- Full FFmpeg support (audio/video)
- Multi-arch: amd64 / arm64
- Production-ready (queue mode)

---

## 📦 Image
```bash
ghcr.io/pedroroms/n8n-ffmpeg/n8n-ffmpeg:<TAG>
````

**Production example:**

```bash
ghcr.io/pedroroms/n8n-ffmpeg/n8n-ffmpeg:1.121.3
```

> ❗ Do not use `latest` in production.

---

## 🚀 Usage

### Docker

```bash
docker pull ghcr.io/pedroroms/n8n-ffmpeg/n8n-ffmpeg:1.121.3
```

### EasyPanel

Use the same image for:

* n8n-editor
* n8n-webhook
* n8n-worker

---

## 🏗️ Recommended Architecture

* Editor
* Webhook
* Worker
* Postgres
* Redis

---

## 🔁 Updates

Updates are **tag-based and controlled**. Rollback is done by switching back to the previous tag.

---

## 🛡️ Production Best Practices

* Always use Postgres
* Enable queue mode with Redis
* Separate Editor / Webhook / Worker
* Daily Postgres backups

---

Maintained by **AutomaxDigital**.

````

---

# 🧩 EasyPanel Template — Manual

## Services
- `n8n-editor` (domain)
- `n8n-webhook` (domain)
- `n8n-worker` (no domain)
- `n8n-postgres`
- `n8n-redis`

## Image
```bash
ghcr.io/pedroroms/n8n-ffmpeg/n8n-ffmpeg:<TAG>
````

## Startup order

1. Postgres
2. Redis
3. n8n-editor
4. n8n-webhook
5. n8n-worker

---

## 📌 Final note

This is the **official AutomaxDigital production manual** for n8n. It can be versioned, shared with clients, or used as a SaaS foundation.
