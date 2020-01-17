#!/bin/bash
set -e

echo "Initializing cache..."
$(which squid) -N -f /etc/squid/squid.conf -z

echo "Starting squid on $(hostname -I) ($(hostname):3128)..."
exec $(which squid) -f /etc/squid/squid.conf -NYCd 1
