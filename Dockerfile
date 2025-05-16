FROM homeassistant/armv7-base:latest

# Install Avahi and socat for mDNS forwarding
RUN apk add --no-cache avahi socat

# Add your reflector script
COPY avahi-reflector.sh /usr/local/bin/avahi-reflector.sh

# Set the script as executable
RUN chmod +x /usr/local/bin/avahi-reflector.sh

# Start Avahi daemon and the reflector script
CMD ["sh", "-c", "/usr/sbin/avahi-daemon && /usr/local/bin/avahi-reflector.sh"]