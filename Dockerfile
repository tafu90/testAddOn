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
##RUN apk add --no-cache avahi socat nss-mdns

RUN apk update && \
    apk add --no-cache avahi socat \
    && apk add --no-cache --virtual .build-deps \
       gcc make libc-dev \
    && wget https://github.com/dgraziotin/nss-mdns/archive/refs/tags/0.10.1.tar.gz \
    && tar -xzvf 0.10.1.tar.gz \
    && cd nss-mdns-0.10.1 && make && make install \
    && cd .. && rm -rf nss-mdns-0.10.1 0.10.1.tar.gz \
    && apk del .build-deps

# Copy the run.sh script into the container
COPY run.sh /usr/local/bin/run.sh

# Make the script executable
RUN chmod +x /usr/local/bin/run.sh

# Set the run.sh as the main entry point
ENTRYPOINT ["/usr/local/bin/run.sh"]
