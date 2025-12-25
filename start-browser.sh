#!/bin/bash

echo "🚀 Starting Binance Browser Environment..."

# Kill any existing processes
pkill -f Xvfb 2>/dev/null || true
pkill -f x11vnc 2>/dev/null || true
pkill -f fluxbox 2>/dev/null || true
pkill -f chromium 2>/dev/null || true
pkill -f websockify 2>/dev/null || true

sleep 1

# Set display
export DISPLAY=:99

# Start virtual display (1920x1080 for better viewing)
echo "📺 Starting virtual display..."
Xvfb :99 -screen 0 1920x1080x24 &
sleep 2

# Start window manager
echo "🪟 Starting window manager..."
fluxbox &
sleep 1

# Start VNC server
echo "🔌 Starting VNC server..."
x11vnc -display :99 -nopw -listen localhost -xkb -forever -shared &
sleep 1

# Start noVNC (web-based VNC client)
echo "🌐 Starting noVNC web client on port 6080..."
websockify --web=/usr/share/novnc 6080 localhost:5900 &
sleep 1

# Find extension directory
EXTENSION_DIR=""
if [ -d "/workspaces" ]; then
  for dir in /workspaces/*/extension; do
    if [ -d "$dir" ] && [ -f "$dir/manifest.json" ]; then
      EXTENSION_DIR="$dir"
      break
    fi
  done
fi

# Launch Chromium with Binance URL
echo "🌍 Launching Chromium browser..."
CHROMIUM_ARGS=(
  "--no-sandbox"
  "--disable-dev-shm-usage"
  "--disable-gpu"
  "--disable-software-rasterizer"
  "--remote-debugging-port=9222"
  "--window-size=1920,1080"
  "--start-maximized"
)

# Add extension if found
if [ -n "$EXTENSION_DIR" ] && [ -d "$EXTENSION_DIR" ]; then
  echo "📦 Loading extension from: $EXTENSION_DIR"
  CHROMIUM_ARGS+=("--load-extension=$EXTENSION_DIR")
fi

# Add the Binance URL
CHROMIUM_ARGS+=("https://www.binance.com/en-IN/futures/funding-history/perpetual/arbitrage-data")

chromium-browser "${CHROMIUM_ARGS[@]}" &

echo ""
echo "✅ Browser environment started!"
echo ""
echo "📌 Access Methods:"
echo "   1. noVNC (Browser): Open port 6080 from the Ports tab"
echo "   2. DevTools: Open port 9222 from the Ports tab"
echo ""
echo "📝 To load extension manually:"
echo "   1. Go to chrome://extensions"
echo "   2. Enable Developer mode"
echo "   3. Click 'Load unpacked'"
echo "   4. Select the 'extension' folder"
echo ""
echo "🔗 Target URL: https://www.binance.com/en-IN/futures/funding-history/perpetual/arbitrage-data"
echo ""
