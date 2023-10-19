#!/bin/vbash
# shellcheck disable=all

set service ssh disable-password-authentication
set service ssh port '22'
set service ntp server ntp.bsn.go.id prefer
set service ntp server time.google.com
set service ntp server time.cloudflare.com
set service ntp listen-address '172.16.10.254'

# MGMT NETWORK DHCP server
set service dhcp-server shared-network-name MGMT authoritative
set service dhcp-server shared-network-name MGMT ping-check
set service dhcp-server shared-network-name MGMT subnet 172.16.10.0/24 default-router '172.16.10.254'
set service dhcp-server shared-network-name MGMT subnet 172.16.10.0/24 lease '86400'
set service dhcp-server shared-network-name MGMT subnet 172.16.10.0/24 name-server '203.142.82.222'
set service dhcp-server shared-network-name MGMT subnet 172.16.10.0/24 range 0 start '172.16.10.200'
set service dhcp-server shared-network-name MGMT subnet 172.16.10.0/24 range 0 stop '172.16.10.253'
