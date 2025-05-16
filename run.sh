#!/bin/bash


# Set environment variable to disable D-Bus usage
export AVAHI_DAEMON_ARGS="--no-dbus"

# Start the Avahi daemon (without --daemonize and without D-Bus)
# Also run in the foreground
/usr/sbin/avahi-daemon $AVAHI_DAEMON_ARGS --no-chroot &


# Fake Synology mDNS broadcast
#avahi-publish -s "Maina" _http._tcp 5000 &
#avahi-publish -s "Maina" _smb._tcp 445 &

# Forward mDNS between local network (eth0) and VPN (wg0)
##socat UDP4-RECVFROM:5353,SO_BROADCAST,IP_ADD_MEMBERSHIP=224.0.0.251:eth0 UDP4-SENDTO:5353:wg0 &
##socat UDP4-RECVFROM:5353,SO_BROADCAST,IP_ADD_MEMBERSHIP=224.0.0.251:wg0 UDP4-SENDTO:5353:eth0 &

##socat UDP4-RECVFROM:5353,IP_ADD_MEMBERSHIP=224.0.0.251:eth0 UDP4-SENDTO:5353:wg0 &
##socat UDP4-RECVFROM:5353,IP_ADD_MEMBERSHIP=224.0.0.251:wg0 UDP4-SENDTO:5353:eth0 &

# Forward mDNS traffic from eth0 to wg0 (without binding to port 5353)
socat UDP4-LISTEN:5353,fork,reuseaddr UDP4-SENDTO:5353:wg0 &

# Forward mDNS traffic from wg0 to eth0 (without binding to port 5353)
socat UDP4-LISTEN:5353,fork,reuseaddr UDP4-SENDTO:5353:eth0 &

# Receive mDNS on eth0 and forward it to wg0
##socat UDP4-RECVFROM:5353,fork UDP4-SENDTO:5353:wg0 &

# Receive mDNS on wg0 and forward it to eth0
##socat UDP4-RECVFROM:5353,fork UDP4-SENDTO:5353:eth0 &

# Keep container alive
tail -f /dev/null
