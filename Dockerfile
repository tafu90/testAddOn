##FROM homeassistant/armv7-base:latest

# Install Avahi and socat for mDNS forwarding
##RUN apk add --no-cache avahi socat

# Copy the run.sh script into the container
##COPY run.sh /usr/local/bin/run.sh

# Make the script executable
##RUN chmod +x /usr/local/bin/run.sh

# Start the script
##CMD ["/usr/local/bin/run.sh"]


FROM homeassistant/armv7-base:latest

# Install Avahi and socat for mDNS forwarding
RUN apk add --no-cache avahi socat nss-mdns

# Copy the run.sh script into the container
COPY run.sh /usr/local/bin/run.sh

# Make the script executable
RUN chmod +x /usr/local/bin/run.sh

# Set the run.sh as the main entry point
ENTRYPOINT ["/usr/local/bin/run.sh"]
