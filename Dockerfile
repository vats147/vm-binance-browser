# Fly.io Browser Container
# Based on Ubuntu with Chromium, VNC, and noVNC

FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99

# Install dependencies
RUN apt-get update && apt-get install -y \
    xvfb \
    x11vnc \
    fluxbox \
    novnc \
    websockify \
    chromium-browser \
    fonts-liberation \
    fonts-dejavu-core \
    dbus-x11 \
    libxss1 \
    libnss3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    supervisor \
    wget \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy extension files
COPY extension/ /app/extension/

# Copy startup scripts
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Create noVNC index redirect
RUN echo '<html><head><meta http-equiv="refresh" content="0;url=vnc.html?autoconnect=true&resize=scale"></head></html>' > /usr/share/novnc/index.html

# Expose ports
# 6080 = noVNC web interface
# 5900 = VNC server
EXPOSE 6080 5900

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:6080/ || exit 1

# Start supervisor (manages all processes)
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
