# 🚀 Binance Arbitrage Browser - GitHub Codespaces Setup

A browser environment running in GitHub Codespaces with Chrome extension support, designed to access Binance Funding History Arbitrage Data.

## 📋 Quick Start

### 1. Create Codespace
1. Push this repo to GitHub
2. Go to your repo → **Code** → **Codespaces** → **Create codespace on main**
3. Wait for the devcontainer to build (~2-3 minutes first time)

### 2. Start the Browser
Once the Codespace is ready, run:
```bash
./start-browser.sh
```

### 3. Access the Browser

#### Method 1: noVNC (Recommended)
1. Open the **Ports** tab in VS Code
2. Find port **6080** → Click the globe icon or "Open in Browser"
3. You'll see a web-based VNC client with Chromium running

#### Method 2: Chrome DevTools Protocol
1. Open the **Ports** tab
2. Find port **9222** → Make it **Public**
3. Open the forwarded URL to access Chrome DevTools

### 4. Load Extension
In the Chromium browser:
1. Navigate to `chrome://extensions`
2. Enable **Developer mode** (toggle in top-right)
3. Click **Load unpacked**
4. Select the `/workspaces/*/extension` folder
5. Navigate to: `https://www.binance.com/en-IN/futures/funding-history/perpetual/arbitrage-data`

## 🔧 Manual Commands

If you need to run things manually:

```bash
# Update and install dependencies
sudo apt update && sudo apt install -y chromium-browser xvfb x11vnc fluxbox novnc websockify

# Start virtual display
export DISPLAY=:99
Xvfb :99 -screen 0 1920x1080x24 &
sleep 2
fluxbox &

# Start VNC server
x11vnc -display :99 -nopw -listen localhost -xkb -forever &

# Start noVNC web client
websockify --web=/usr/share/novnc 6080 localhost:5900 &

# Launch Chromium
chromium-browser \
  --no-sandbox \
  --disable-dev-shm-usage \
  --disable-gpu \
  --remote-debugging-port=9222 \
  "https://www.binance.com/en-IN/futures/funding-history/perpetual/arbitrage-data" &
```

## 📁 Project Structure

```
.
├── .devcontainer/
│   └── devcontainer.json    # Codespaces configuration
├── extension/               # Your Chrome extension files
│   ├── manifest.json
│   ├── popup.html
│   ├── popup.js
│   └── content.js
├── start-browser.sh         # Quick start script
└── README.md
```

## ⚠️ Known Limitations

| Issue | Reality |
|-------|---------|
| **Cloudflare** | May block some sessions |
| **GPU** | Software rendering only |
| **Audio** | Not available |
| **Idle Timeout** | Codespace sleeps after 30 min idle |
| **Bot Detection** | Some sites may detect automation |

## ✅ This Works Best For

- ✅ Internal tools and testing
- ✅ Extension development
- ✅ UI testing and screenshots
- ✅ Non-protected sites
- ✅ Binance data viewing (public pages)

## ❌ May Not Work For

- ❌ Sites with aggressive anti-bot (Cloudflare, hCaptcha)
- ❌ High-frequency trading
- ❌ Long-running sessions

## 💡 Tips

1. **Keep Active**: Move mouse or interact periodically to prevent idle timeout
2. **Public Port**: Make port 6080 public for easier access
3. **Screen Size**: Default is 1920x1080, modify in start-browser.sh if needed
4. **Extension Reload**: After changes, go to chrome://extensions and click reload

---

Created for Binance Funding History Arbitrage Data access.
