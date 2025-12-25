# 🚀 Fly.io Deployment Guide

## Prerequisites
- Fly.io account (free at [fly.io](https://fly.io))
- Fly CLI installed (`brew install flyctl`)

## Quick Start

### 1. Login to Fly.io
```bash
fly auth login
```

### 2. Launch the App
```bash
fly launch --name binance-browser --region sin --no-deploy
```

### 3. Deploy
```bash
fly deploy
```

### 4. Access Your Browser
```bash
fly open
```

Or visit: `https://binance-browser.fly.dev`

---

## Useful Commands

| Command | Description |
|---------|-------------|
| `fly status` | Check app status |
| `fly logs` | View logs |
| `fly ssh console` | SSH into container |
| `fly apps destroy binance-browser` | Delete app |
| `fly scale memory 2048` | Increase RAM to 2GB |

---

## Free Tier Limits

| Resource | Free Allowance |
|----------|----------------|
| VMs | 3 shared-cpu-1x |
| Memory | 256MB per VM (can upgrade) |
| Bandwidth | Generous |

---

## Troubleshooting

### Browser not loading?
```bash
fly ssh console
supervisorctl status
```

### Restart services
```bash
fly apps restart binance-browser
```

### View real-time logs
```bash
fly logs -a binance-browser
```
