#!/bin/vbash
# shellcheck disable=all

# PPPoE
set interfaces pppoe pppoe0 authentication password '253742'
set interfaces pppoe pppoe0 authentication username '165170275001'
set interfaces pppoe pppoe0 description 'WAN - Biznet PPPoE'
set interfaces pppoe pppoe0 mtu '1500'
set interfaces pppoe pppoe0 ip adjust-mss '1460'
set interfaces pppoe pppoe0 source-interface 'bond0.1616'

# ALL -> WAN masquerade
set nat source rule 100 description 'ALL -> WAN'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 outbound-interface 'pppoe0'
set nat source rule 100 translation address 'masquerade'
