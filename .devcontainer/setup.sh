#!/bin/bash
set -e

echo "🔧 Setting up browser environment..."

# Update package lists
sudo apt update

# Install display dependencies first
sudo apt install -y \
  xvfb \
  x11vnc \
  fluxbox \
  novnc \
  websockify \
  fonts-liberation \
  fonts-dejavu-core \
  dbus-x11 \
  libxss1 \
  libnss3 \
  libatk-bridge2.0-0 \
  libgtk-3-0 \
  libgbm1 \
  wget \
  unzip

# Install Chromium - try multiple methods
echo "📦 Installing Chromium browser..."

# Method 1: Try installing chromium (without -browser suffix)
if sudo apt install -y chromium 2>/dev/null; then
  echo "✅ Chromium installed via apt (chromium)"
  CHROMIUM_CMD="chromium"
# Method 2: Try snap
elif command -v snap &> /dev/null; then
  echo "📦 Trying snap installation..."
  sudo snap install chromium 2>/dev/null && CHROMIUM_CMD="chromium" || true
# Method 3: Download from official source
else
  echo "📦 Downloading Chromium..."
  wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
  sudo apt install -y /tmp/chrome.deb 2>/dev/null || true
  rm -f /tmp/chrome.deb
  CHROMIUM_CMD="google-chrome"
fi

# Create a symlink for consistent command
if [ -n "$CHROMIUM_CMD" ]; then
  sudo ln -sf $(which $CHROMIUM_CMD) /usr/local/bin/browser 2>/dev/null || true
fi

# Create necessary directories
mkdir -p ~/.vnc
mkdir -p ~/.fluxbox

# Configure fluxbox
cat > ~/.fluxbox/init << 'EOF'
session.screen0.toolbar.visible: false
session.screen0.fullMaximization: true
EOF

# Make start script executable
chmod +x /workspaces/*/start-browser.sh 2>/dev/null || true

echo "✅ Setup complete!"
echo "Run './start-browser.sh' to start the browser environment"
