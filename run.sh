#!/bin/bash


# Start the Avahi daemon to handle mDNS service discovery
/usr/sbin/avahi-daemon --no-dbus --daemonize=no &


# Fake Synology mDNS broadcast
#avahi-publish -s "Maina" _http._tcp 5000 &
#avahi-publish -s "Maina" _smb._tcp 445 &

# Forward mDNS between local network (eth0) and VPN (wg0)
##socat UDP4-RECVFROM:5353,SO_BROADCAST,IP_ADD_MEMBERSHIP=224.0.0.251:eth0 UDP4-SENDTO:5353:wg0 &
##socat UDP4-RECVFROM:5353,SO_BROADCAST,IP_ADD_MEMBERSHIP=224.0.0.251:wg0 UDP4-SENDTO:5353:eth0 &

##socat UDP4-RECVFROM:5353,IP_ADD_MEMBERSHIP=224.0.0.251:eth0 UDP4-SENDTO:5353:wg0 &
##socat UDP4-RECVFROM:5353,IP_ADD_MEMBERSHIP=224.0.0.251:wg0 UDP4-SENDTO:5353:eth0 &

# Forward mDNS between local network (eth0) and VPN (wg0)
socat UDP4-RECVFROM:5353 UDP4-SENDTO:5353:wg0 &
socat UDP4-RECVFROM:5353 UDP4-SENDTO:5353:eth0 &
# Keep container alive
tail -f /dev/null
