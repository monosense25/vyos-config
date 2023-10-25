#!/bin/vbash
# shellcheck disable=all

# Force DNS
set nat destination rule 102 description 'Force DNS for IOT VLAN'
set nat destination rule 102 destination address '!172.16.16.5'
set nat destination rule 102 destination port '53'
set nat destination rule 102 inbound-interface 'bond0.1613'
set nat destination rule 102 protocol 'tcp_udp'
set nat destination rule 102 translation address '172.16.16.5'
set nat destination rule 102 translation port '53'

set nat destination rule 103 description 'Force DNS for CCTV VLAN'
set nat destination rule 103 destination address '!172.16.16.5'
set nat destination rule 103 destination port '53'
set nat destination rule 103 inbound-interface 'bond0.1614'
set nat destination rule 103 protocol 'tcp_udp'
set nat destination rule 103 translation address '172.16.16.5'
set nat destination rule 103 translation port '53'

# Force NTP
set nat destination rule 104 description 'Force NTP for MGMT'
set nat destination rule 104 destination address '!172.16.10.254'
set nat destination rule 104 destination port '123'
set nat destination rule 104 inbound-interface 'bond0'
set nat destination rule 104 protocol 'udp'
set nat destination rule 104 translation address '172.16.10.254'
set nat destination rule 104 translation port '123'

set nat destination rule 105 description 'Force NTP for INFRA'
set nat destination rule 105 destination address '!172.16.10.254'
set nat destination rule 105 destination port '123'
set nat destination rule 105 inbound-interface 'bond0.1611'
set nat destination rule 105 protocol 'udp'
set nat destination rule 105 translation address '172.16.10.254'
set nat destination rule 105 translation port '123'

set nat destination rule 106 description 'Force NTP for HOME VLAN'
set nat destination rule 106 destination address '!172.16.10.254'
set nat destination rule 106 destination port '123'
set nat destination rule 106 inbound-interface 'bond0.1612'
set nat destination rule 106 protocol 'udp'
set nat destination rule 106 translation address '172.16.10.254'
set nat destination rule 106 translation port '123'

set nat destination rule 107 description 'Force NTP for IOT VLAN'
set nat destination rule 107 destination address '!172.16.10.254'
set nat destination rule 107 destination port '123'
set nat destination rule 107 inbound-interface 'bond0.1613'
set nat destination rule 107 protocol 'udp'
set nat destination rule 107 translation address '172.16.10.254'
set nat destination rule 107 translation port '123'

set nat destination rule 108 description 'Force NTP for CCTV VLAN'
set nat destination rule 108 destination address '!172.16.10.254'
set nat destination rule 108 destination port '123'
set nat destination rule 108 inbound-interface 'bond0.1614'
set nat destination rule 108 protocol 'udp'
set nat destination rule 108 translation address '172.16.10.254'
set nat destination rule 108 translation port '123'

# set nat destination rule 109 description 'Force NTP for WIREGUARD'
# set nat destination rule 109 destination address '!10.10.0.1'
# set nat destination rule 109 destination port '123'
# set nat destination rule 109 inbound-interface 'wg0'
# set nat destination rule 109 protocol 'udp'
# set nat destination rule 109 translation address '10.10.0.1'
# set nat destination rule 109 translation port '123'

# LAN -> WAN masquerade
set nat source rule 100 description 'LAN -> WAN'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 outbound-interface 'pppoe0'
set nat source rule 100 translation address 'masquerade'
