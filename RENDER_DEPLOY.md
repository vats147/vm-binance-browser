# 🚀 Render.com Deployment Guide

## ✅ NO Credit Card Required!

Render.com offers 750 free hours/month without requiring a payment method.

---

## Quick Start

### Step 1: Go to Render.com
1. Visit [render.com](https://render.com)
2. Click **"Get Started for Free"**
3. Sign up with **GitHub** (recommended)

### Step 2: Create New Web Service
1. Click **"New +"** → **"Web Service"**
2. Connect your GitHub account (if not already)
3. Select repository: `vats147/vm-binance-browser`
4. Click **"Connect"**

### Step 3: Configure Settings

| Setting | Value |
|---------|-------|
| **Name** | `binance-browser` |
| **Region** | `Singapore` |
| **Branch** | `main` |
| **Runtime** | `Docker` |
| **Instance Type** | `Free` |

### Step 4: Deploy
1. Click **"Create Web Service"**
2. Wait for build (~5-10 minutes first time)
3. Once deployed, click the URL to access your browser!

---

## Access Your Browser

After deployment, your browser will be available at:
```
https://binance-browser.onrender.com
```

(Or whatever name you chose)

---

## Free Tier Limits

| Resource | Free Allowance |
|----------|----------------|
| Hours | 750/month |
| RAM | 512MB |
| CPU | Shared |
| Sleep | After 15 min inactivity |

**Note:** Free tier services "sleep" after 15 minutes of inactivity. First request after sleep takes ~30 seconds to wake up.

---

## Troubleshooting

### Service sleeping?
Just refresh the page - it will wake up in ~30 seconds.

### Build failed?
Check the build logs in Render dashboard for errors.

### Browser not showing?
Make sure to navigate to `/vnc.html` if you see a directory listing.

---

## Alternative: One-Click Deploy

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/vats147/vm-binance-browser)
