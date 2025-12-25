#!/bin/bash

echo "🚀 Starting Binance Browser Environment..."

# Start virtual display
export DISPLAY=:99
Xvfb :99 -screen 0 1920x1080x24 &
sleep 2

# Start window manager
fluxbox &
sleep 1

# Start VNC server
x11vnc -display :99 -nopw -listen 0.0.0.0 -xkb -forever -shared &
sleep 1

# Start noVNC
websockify --web=/usr/share/novnc 6080 localhost:5900 &
sleep 1

# Start Chromium
chromium-browser \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --disable-software-rasterizer \
    --window-size=1920,1080 \
    --start-maximized \
    --load-extension=/app/extension \
    "https://www.binance.com/en-IN/futures/funding-history/perpetual/arbitrage-data" &

echo "✅ Browser started!"
echo "📌 Access via port 6080"

# Keep container running
tail -f /dev/null
