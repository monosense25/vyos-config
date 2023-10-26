#!/bin/vbash
# shellcheck disable=all

# PPPoE
set interfaces pppoe pppoe0 authentication username "${SECRET_WAN_PPPOE_USER}"
set interfaces pppoe pppoe0 authentication password "${SECRET_WAN_PPPOE_PASS}"
set interfaces pppoe pppoe0 description 'WAN - PPPoE'
set interfaces pppoe pppoe0 mtu '1492'
set interfaces pppoe pppoe0 ip adjust-mss clamp-mss-to-pmtu
set interfaces pppoe pppoe0 source-interface 'eth0'
