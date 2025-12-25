#!/bin/bash
set -e

echo "🔧 Setting up browser environment..."

# Update package lists
sudo apt update

# Install Chromium browser and display dependencies
sudo apt install -y \
  chromium-browser \
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
  libgbm1

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
