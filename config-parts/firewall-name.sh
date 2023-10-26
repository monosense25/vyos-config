#!/bin/vbash
# shellcheck disable=all

#### MGMT
set firewall ipv4 name MGMT-LOCAL default-action 'accept'
set firewall ipv4 name MGMT-LOCAL description 'From MGMT to LOCAL(VYOS) Zone'
set firewall ipv4 name MGMT-LOCAL enable-default-log
set firewall ipv4 name MGMT-LOCAL rule 999 description 'Drop Invalid'
set firewall ipv4 name MGMT-LOCAL rule 999 action 'drop'
set firewall ipv4 name MGMT-LOCAL rule 999 state invalid 'enable'
set firewall ipv4 name MGMT-LOCAL rule 999 log 'enable'

set firewall ipv4 name MGMT-INFRA default-action 'accept'
set firewall ipv4 name MGMT-INFRA description 'From MGMT to INFRA Zone'
set firewall ipv4 name MGMT-INFRA enable-default-log
set firewall ipv4 name MGMT-INFRA rule 999 description 'Drop Invalid'
set firewall ipv4 name MGMT-INFRA rule 999 action 'drop'
set firewall ipv4 name MGMT-INFRA rule 999 state invalid 'enable'Í
set firewall ipv4 name MGMT-INFRA rule 999 log 'enable'

set firewall ipv4 name MGMT-HOME default-action 'accept'
set firewall ipv4 name MGMT-HOME description 'From MGMT to HOME Zone'
set firewall ipv4 name MGMT-HOME enable-default-log
set firewall ipv4 name MGMT-HOME rule 999 description 'Drop Invalid'
set firewall ipv4 name MGMT-HOME rule 999 action 'drop'
set firewall ipv4 name MGMT-HOME rule 999 state invalid 'enable'Í
set firewall ipv4 name MGMT-HOME rule 999 log 'enable'

set firewall ipv4 name MGMT-IOT default-action 'accept'
set firewall ipv4 name MGMT-IOT description 'From MGMT to IOT Zone'
set firewall ipv4 name MGMT-IOT enable-default-log
set firewall ipv4 name MGMT-IOT rule 999 description 'Drop Invalid'
set firewall ipv4 name MGMT-IOT rule 999 action 'drop'
set firewall ipv4 name MGMT-IOT rule 999 state invalid 'enable'Í
set firewall ipv4 name MGMT-IOT rule 999 log 'enable'

set firewall ipv4 name MGMT-CCTV default-action 'accept'
set firewall ipv4 name MGMT-CCTV description 'From MGMT to CCTV Zone'
set firewall ipv4 name MGMT-CCTV enable-default-log
set firewall ipv4 name MGMT-CCTV rule 999 description 'Drop Invalid'
set firewall ipv4 name MGMT-CCTV rule 999 action 'drop'
set firewall ipv4 name MGMT-CCTV rule 999 state invalid 'enable'Í
set firewall ipv4 name MGMT-CCTV rule 999 log 'enable'

set firewall ipv4 name MGMT-CONTAINERS default-action 'accept'
set firewall ipv4 name MGMT-CONTAINERS description 'From MGMT to CONTAINERS Zone'
set firewall ipv4 name MGMT-CONTAINERS enable-default-log
set firewall ipv4 name MGMT-CONTAINERS rule 999 description 'Drop Invalid'
set firewall ipv4 name MGMT-CONTAINERS rule 999 action 'drop'
set firewall ipv4 name MGMT-CONTAINERS rule 999 state invalid 'enable'
set firewall ipv4 name MGMT-CONTAINERS rule 999 log 'enable'

#### INFRA
set firewall ipv4 name INFRA-LOCAL description 'From INFRA to LOCAL(VYOS) Zone'
set firewall ipv4 name INFRA-LOCAL default-action 'drop'
set firewall ipv4 name INFRA-LOCAL enable-default-log
set firewall ipv4 name INFRA-LOCAL rule 10 description 'Allow DHCP'
set firewall ipv4 name INFRA-LOCAL rule 10 action 'accept'
set firewall ipv4 name INFRA-LOCAL rule 10 protocol 'udp'
set firewall ipv4 name INFRA-LOCAL rule 10 source port '67,68'
set firewall ipv4 name INFRA-LOCAL rule 10 destination port '67,68'
set firewall ipv4 name INFRA-LOCAL rule 20 description 'Allow NTP'
set firewall ipv4 name INFRA-LOCAL rule 20 action 'accept'
set firewall ipv4 name INFRA-LOCAL rule 20 protocol 'udp'
set firewall ipv4 name INFRA-LOCAL rule 20 destination port '123'
set firewall ipv4 name INFRA-LOCAL rule 40 description 'Allow BGP'
set firewall ipv4 name INFRA-LOCAL rule 40 action 'accept'
set firewall ipv4 name INFRA-LOCAL rule 40 protocol 'tcp'
set firewall ipv4 name INFRA-LOCAL rule 40 destination port '179'
set firewall ipv4 name INFRA-LOCAL rule 50 description 'Allow TFTP'
set firewall ipv4 name INFRA-LOCAL rule 50 action 'accept'
set firewall ipv4 name INFRA-LOCAL rule 50 protocol 'tcp'
set firewall ipv4 name INFRA-LOCAL rule 50 destination port '179'
set firewall ipv4 name INFRA-LOCAL rule 60 description 'Allow ICMP request'
set firewall ipv4 name INFRA-LOCAL rule 60 action 'accept'
set firewall ipv4 name INFRA-LOCAL rule 60 protocol 'icmp'
set firewall ipv4 name INFRA-LOCAL rule 70 description 'Allow NODE-EXPORTER from K8S Nodes'
set firewall ipv4 name INFRA-LOCAL rule 70 action 'accept'
set firewall ipv4 name INFRA-LOCAL rule 70 protocol 'tcp'
set firewall ipv4 name INFRA-LOCAL rule 70 source group address-group 'FW_AG_K8S_INFRA_NODES'
set firewall ipv4 name INFRA-LOCAL rule 70 destination port '9100'
set firewall ipv4 name INFRA-LOCAL rule 999 description 'drop invalid'
set firewall ipv4 name INFRA-LOCAL rule 999 action 'drop'
set firewall ipv4 name INFRA-LOCAL rule 999 state invalid 'enable'
set firewall ipv4 name INFRA-LOCAL rule 999 log 'enable'


#### HOME
set firewall ipv4 name HOME-LOCAL description 'From HOME to LOCAL(VYOS) Zone'
set firewall ipv4 name HOME-LOCAL default-action 'drop'
set firewall ipv4 name HOME-LOCAL enable-default-log
set firewall ipv4 name HOME-LOCAL rule 10 description 'Allow DHCP'
set firewall ipv4 name HOME-LOCAL rule 10 action 'accept'
set firewall ipv4 name HOME-LOCAL rule 10 protocol 'udp'
set firewall ipv4 name HOME-LOCAL rule 10 source port '67,68'
set firewall ipv4 name HOME-LOCAL rule 10 destination port '67,68'
set firewall ipv4 name HOME-LOCAL rule 20 description 'Allow NTP'
set firewall ipv4 name HOME-LOCAL rule 20 action 'accept'
set firewall ipv4 name HOME-LOCAL rule 20 protocol 'udp'
set firewall ipv4 name HOME-LOCAL rule 20 destination port '123'
set firewall ipv4 name HOME-LOCAL rule 30 description 'Allow SSH from MBP'
set firewall ipv4 name HOME-LOCAL rule 30 action 'accept'
set firewall ipv4 name HOME-LOCAL rule 30 protocol 'tcp'
set firewall ipv4 name HOME-LOCAL rule 30 destination port '22'
set firewall ipv4 name HOME-LOCAL rule 30 source group mac-group 'FW_MG_HOME'
set firewall ipv4 name HOME-LOCAL rule 999 description 'drop invalid'
set firewall ipv4 name HOME-LOCAL rule 999 action 'drop'
set firewall ipv4 name HOME-LOCAL rule 999 state invalid 'enable'
set firewall ipv4 name HOME-LOCAL rule 999 log 'enable'

set firewall ipv4 name HOME-MGMT description 'From HOME to MGMT Zone'
set firewall ipv4 name HOME-MGMT default-action 'drop'
set firewall ipv4 name HOME-MGMT enable-default-log
set firewall ipv4 name HOME-MGMT rule 999 description 'drop invalid'
set firewall ipv4 name HOME-MGMT rule 999 action 'drop'
set firewall ipv4 name HOME-MGMT rule 999 state invalid 'enable'
set firewall ipv4 name HOME-MGMT rule 999 log 'enable'

set firewall ipv4 name HOME-INFRA description 'From HOME to INFRA Zone'
set firewall ipv4 name HOME-INFRA default-action 'drop'
set firewall ipv4 name HOME-INFRA enable-default-log
set firewall ipv4 name HOME-INFRA rule 10 description 'Allow HTTP/HTTPS'
set firewall ipv4 name HOME-INFRA rule 10 action 'accept'
set firewall ipv4 name HOME-INFRA rule 10 protocol 'tcp'
set firewall ipv4 name HOME-INFRA rule 10 destination port 'http,https'
set firewall ipv4 name HOME-INFRA rule 20 description 'Allow TALOS API from MBP'
set firewall ipv4 name HOME-INFRA rule 20 action 'accept'
set firewall ipv4 name HOME-INFRA rule 20 protocol 'tcp'
set firewall ipv4 name HOME-INFRA rule 20 source group mac-group 'FW_MG_HOME'
set firewall ipv4 name HOME-INFRA rule 20 destination port 50000
set firewall ipv4 name HOME-INFRA rule 999 description 'drop invalid'
set firewall ipv4 name HOME-INFRA rule 999 action 'drop'
set firewall ipv4 name HOME-INFRA rule 999 state invalid 'enable'
set firewall ipv4 name HOME-INFRA rule 999 log 'enable'

set firewall ipv4 name HOME-IOT description 'From HOME to IOT Zone'
set firewall ipv4 name HOME-IOT default-action 'drop'
set firewall ipv4 name HOME-IOT enable-default-log
set firewall ipv4 name HOME-IOT rule 999 description 'drop invalid'
set firewall ipv4 name HOME-IOT rule 999 action 'drop'
set firewall ipv4 name HOME-IOT rule 999 state invalid 'enable'
set firewall ipv4 name HOME-IOT rule 999 log 'enable'

set firewall ipv4 name HOME-CCTV description 'From HOME to CCTV Zone'
set firewall ipv4 name HOME-CCTV default-action 'drop'
set firewall ipv4 name HOME-CCTV enable-default-log
set firewall ipv4 name HOME-CCTV rule 10 description 'Allow HTTP/HTTPS'
set firewall ipv4 name HOME-CCTV rule 10 action 'accept'
set firewall ipv4 name HOME-CCTV rule 10 protocol 'tcp'
set firewall ipv4 name HOME-CCTV rule 10 destination port 'http,https'
set firewall ipv4 name HOME-CCTV rule 999 description 'drop invalid'
set firewall ipv4 name HOME-CCTV rule 999 action 'drop'
set firewall ipv4 name HOME-CCTV rule 999 state invalid 'enable'
set firewall ipv4 name HOME-CCTV rule 999 log 'enable'

set firewall ipv4 name HOME-CONTAINERS description 'From HOME to CONTAINERS Zone'
set firewall ipv4 name HOME-CONTAINERS default-action 'drop'
set firewall ipv4 name HOME-CONTAINERS enable-default-log
set firewall ipv4 name HOME-CONTAINERS rule 10 description 'Allow DNS'
set firewall ipv4 name HOME-CONTAINERS rule 10 action 'accept'
set firewall ipv4 name HOME-CONTAINERS rule 10 protocol 'tcp_udp'
set firewall ipv4 name HOME-CONTAINERS rule 10 destination port 'domain,domain_s'
set firewall ipv4 name HOME-CONTAINERS rule 10 destination group address-group 'FW_AG_FYOS_DNS'
set firewall ipv4 name HOME-CONTAINERS rule 20 description 'Allow HTTP/HTTPS from MBP'
set firewall ipv4 name HOME-CONTAINERS rule 20 action 'accept'
set firewall ipv4 name HOME-CONTAINERS rule 20 protocol 'tcp'
set firewall ipv4 name HOME-CONTAINERS rule 20 source group mac-group 'FW_MG_HOME'
set firewall ipv4 name HOME-CONTAINERS rule 20 destination port 'http,https'
set firewall ipv4 name HOME-CONTAINERS rule 999 description 'drop invalid'
set firewall ipv4 name HOME-CONTAINERS rule 999 action 'drop'
set firewall ipv4 name HOME-CONTAINERS rule 999 state invalid 'enable'
set firewall ipv4 name HOME-CONTAINERS rule 999 log 'enable'

set firewall ipv4 name CONTAINERS-MGMT default-action 'accept'
set firewall ipv4 name CONTAINERS-MGMT description 'From CONTAINERS to MGMT Zone'
set firewall ipv4 name CONTAINERS-MGMT enable-default-log
set firewall ipv4 name CONTAINERS-MGMT rule 999 description 'Drop Invalid'
set firewall ipv4 name CONTAINERS-MGMT rule 999 action 'drop'
set firewall ipv4 name CONTAINERS-MGMT rule 999 state invalid 'enable'
set firewall ipv4 name CONTAINERS-MGMT rule 999 log 'enable'

set firewall ipv4 name WAN-LOCAL description 'From WAN to LOCAL(VYOS) Zone'
set firewall ipv4 name WAN-LOCAL default-action 'drop'
set firewall ipv4 name WAN-LOCAL enable-default-log
set firewall ipv4 name WAN-LOCAL rule 10 description 'Drop Invalid'
set firewall ipv4 name WAN-LOCAL rule 10 action 'drop'
set firewall ipv4 name WAN-LOCAL rule 10 state invalid 'enable'
set firewall ipv4 name WAN-LOCAL rule 10 log 'enable'
set firewall ipv4 name WAN-LOCAL rule 20 description 'Allow access to Wireguard'
set firewall ipv4 name WAN-LOCAL rule 20 action 'accept'
set firewall ipv4 name WAN-LOCAL rule 20 protocol 'udp'
set firewall ipv4 name WAN-LOCAL rule 20 destination port '51821'
set firewall ipv4 name WAN-MGMT description 'From WAN to MGMT Zone'
set firewall ipv4 name WAN-MGMT default-action 'drop'
set firewall ipv4 name WAN-MGMT enable-default-log
set firewall ipv4 name WAN-MGMT rule 999 description 'Drop Invalid'
set firewall ipv4 name WAN-MGMT rule 999 action 'drop'
set firewall ipv4 name WAN-MGMT rule 999 state invalid 'enable'
set firewall ipv4 name WAN-MGMT rule 999 log 'enable'
set firewall ipv4 name WAN-INFRA description 'From WAN to INFRA Zone'
set firewall ipv4 name WAN-INFRA default-action 'drop'
set firewall ipv4 name WAN-INFRA enable-default-log
set firewall ipv4 name WAN-INFRA rule 999 description 'Drop Invalid'
set firewall ipv4 name WAN-INFRA rule 999 action 'drop'
set firewall ipv4 name WAN-INFRA rule 999 state invalid 'enable'
set firewall ipv4 name WAN-INFRA rule 999 log 'enable'
set firewall ipv4 name WAN-HOME description 'From WAN to HOME Zone'
set firewall ipv4 name WAN-HOME default-action 'drop'
set firewall ipv4 name WAN-HOME enable-default-log
set firewall ipv4 name WAN-HOME rule 999 description 'Drop Invalid'
set firewall ipv4 name WAN-HOME rule 999 action 'drop'
set firewall ipv4 name WAN-HOME rule 999 state invalid 'enable'
set firewall ipv4 name WAN-HOME rule 999 log 'enable'
set firewall ipv4 name WAN-IOT description 'From WAN to IOT Zone'
set firewall ipv4 name WAN-IOT default-action 'drop'
set firewall ipv4 name WAN-IOT enable-default-log
set firewall ipv4 name WAN-IOT rule 999 description 'Drop Invalid'
set firewall ipv4 name WAN-IOT rule 999 action 'drop'
set firewall ipv4 name WAN-IOT rule 999 state invalid 'enable'
set firewall ipv4 name WAN-IOT rule 999 log 'enable'
set firewall ipv4 name WAN-CCTV description 'From WAN to CCTV Zone'
set firewall ipv4 name WAN-CCTV default-action 'drop'
set firewall ipv4 name WAN-CCTV enable-default-log
set firewall ipv4 name WAN-CCTV rule 999 description 'Drop Invalid'
set firewall ipv4 name WAN-CCTV rule 999 action 'drop'
set firewall ipv4 name WAN-CCTV rule 999 state invalid 'enable'
set firewall ipv4 name WAN-CCTV rule 999 log 'enable'
set firewall ipv4 name WAN-CONTAINERS description 'From WAN to CONTAINERS Zone'
set firewall ipv4 name WAN-CONTAINERS default-action 'drop'
set firewall ipv4 name WAN-CONTAINERS enable-default-log
set firewall ipv4 name WAN-CONTAINERS rule 999 description 'Drop Invalid'
set firewall ipv4 name WAN-CONTAINERS rule 999 action 'drop'
set firewall ipv4 name WAN-CONTAINERS rule 999 state invalid 'enable'
set firewall ipv4 name WAN-CONTAINERS rule 999 log 'enable'
set firewall ipv4 name LOCAL-WAN description 'From LOCAL(VYOS) to WAN Zone'
set firewall ipv4 name LOCAL-WAN default-action 'accept'
set firewall ipv4 name MGMT-WAN description 'From MGMT to WAN Zone'
set firewall ipv4 name MGMT-WAN default-action 'accept'
set firewall ipv4 name INFRA-WAN description 'From INFRA to WAN Zone'
set firewall ipv4 name INFRA-WAN default-action 'accept'
set firewall ipv4 name HOME-WAN description 'From HOME to WAN Zone'
set firewall ipv4 name HOME-WAN default-action 'accept'
set firewall ipv4 name IOT-WAN description 'From IOT to WAN Zone'
set firewall ipv4 name IOT-WAN default-action 'accept'
set firewall ipv4 name CCTV-WAN description 'From CCTV to WAN Zone'
set firewall ipv4 name CCTV-WAN default-action 'accept'
set firewall ipv4 name CONTAINERS-WAN description 'From CONTAINERS to WAN Zone'
set firewall ipv4 name CONTAINERS-WAN default-action 'accept'





############################################################################################################ 
# FW NAME RULE IPV4
############################################################################################################
# From VYOS to MGMT
set firewall ipv4 name VYOS-MGMT-v4 default-action 'drop'
set firewall ipv4 name VYOS-MGMT-v4 description 'From LOCAL to MGMT'
set firewall ipv4 name VYOS-MGMT-v4 enable-default-log
set firewall ipv4 name VYOS-MGMT-v4 rule 100 action 'accept'
set firewall ipv4 name VYOS-MGMT-v4 rule 100 description 'Rule: Accept_IGMP'
set firewall ipv4 name VYOS-MGMT-v4 rule 100 protocol '2'
set firewall ipv4 name VYOS-MGMT-v4 rule 110 action 'accept'
set firewall ipv4 name VYOS-MGMT-v4 rule 110 description 'Rule: Accept_MDNS'
set firewall ipv4 name VYOS-MGMT-v4 rule 110 destination port 'mdns'
set firewall ipv4 name VYOS-MGMT-v4 rule 110 protocol 'udp'
set firewall ipv4 name VYOS-MGMT-v4 rule 110 source port 'mdns'
set firewall ipv4 name VYOS-MGMT-v4 rule 400 action 'accept'
set firewall ipv4 name VYOS-MGMT-v4 rule 400 description 'Rule: Accept_wireguard'
set firewall ipv4 name VYOS-MGMT-v4 rule 400 source port '51820'
set firewall ipv4 name VYOS-MGMT-v4 rule 400 protocol 'udp'
set firewall ipv4 name VYOS-MGMT-v4 rule 999 action 'drop'
set firewall ipv4 name VYOS-MGMT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name VYOS-MGMT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name VYOS-MGMT-v4 rule 999 log 'enable'

# From VYOS to INFRA
set firewall ipv4 name VYOS-INFRA-v4 default-action 'drop'
set firewall ipv4 name VYOS-INFRA-v4 description 'From VYOS to INFRA'
set firewall ipv4 name VYOS-INFRA-v4 enable-default-log
set firewall ipv4 name VYOS-INFRA-v4 rule 40 action 'accept'
set firewall ipv4 name VYOS-INFRA-v4 rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name VYOS-INFRA-v4 rule 40 destination port 'domain,domain-s'
set firewall ipv4 name VYOS-INFRA-v4 rule 40 protocol 'tcp_udp'
set firewall ipv4 name VYOS-INFRA-v4 rule 70 action 'accept'
set firewall ipv4 name VYOS-INFRA-v4 rule 70 description 'Rule: Accept_BGP'
set firewall ipv4 name VYOS-INFRA-v4 rule 70 destination port 'bgp'
set firewall ipv4 name VYOS-INFRA-v4 rule 70 protocol 'tcp'
set firewall ipv4 name VYOS-INFRA-v4 rule 100 action 'accept'
set firewall ipv4 name VYOS-INFRA-v4 rule 100 description 'Rule: Accept_k8s_api'
set firewall ipv4 name VYOS-INFRA-v4 rule 100 destination port '6443'
set firewall ipv4 name VYOS-INFRA-v4 rule 100 protocol 'tcp'
set firewall ipv4 name VYOS-INFRA-v4 rule 200 action 'accept'
set firewall ipv4 name VYOS-INFRA-v4 rule 200 description 'Rule: Accept_vector_syslog'
set firewall ipv4 name VYOS-INFRA-v4 rule 200 destination group address-group 'FW_AG_K8S_VECTOR_SVC'
set firewall ipv4 name VYOS-INFRA-v4 rule 200 destination port '6001'
set firewall ipv4 name VYOS-INFRA-v4 rule 200 protocol 'tcp'
set firewall ipv4 name VYOS-INFRA-v4 rule 999 action 'drop'
set firewall ipv4 name VYOS-INFRA-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name VYOS-INFRA-v4 rule 999 state invalid 'enable'
set firewall ipv4 name VYOS-INFRA-v4 rule 999 log 'enable'

# From VYOS to HOME
set firewall ipv4 name VYOS-HOME-v4 default-action 'drop'
set firewall ipv4 name VYOS-HOME-v4 description 'From VYOS to HOME'
set firewall ipv4 name VYOS-HOME-v4 enable-default-log
set firewall ipv4 name VYOS-HOME-v4 rule 999 action 'drop'
set firewall ipv4 name VYOS-HOME-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name VYOS-HOME-v4 rule 999 state invalid 'enable'
set firewall ipv4 name VYOS-HOME-v4 rule 999 log 'enable'

# From VYOS to IOT
set firewall ipv4 name VYOS-IOT-v4 default-action 'drop'
set firewall ipv4 name VYOS-IOT-v4 description 'From VYOS to IOT'
set firewall ipv4 name VYOS-IOT-v4 enable-default-log
set firewall ipv4 name VYOS-IOT-v4 rule 100 action 'accept'
set firewall ipv4 name VYOS-IOT-v4 rule 100 description 'Rule: Accept_IGMP'
set firewall ipv4 name VYOS-IOT-v4 rule 100 protocol '2'
set firewall ipv4 name VYOS-IOT-v4 rule 110 action 'accept'
set firewall ipv4 name VYOS-IOT-v4 rule 110 description 'Rule: Accept_MDNS'
set firewall ipv4 name VYOS-IOT-v4 rule 110 destination port 'mdns'
set firewall ipv4 name VYOS-IOT-v4 rule 110 protocol 'udp'
set firewall ipv4 name VYOS-IOT-v4 rule 110 source port 'mdns'
set firewall ipv4 name VYOS-IOT-v4 rule 999 action 'drop'
set firewall ipv4 name VYOS-IOT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name VYOS-IOT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name VYOS-IOT-v4 rule 999 log 'enable'

# From VYOS to CCTV
set firewall ipv4 name VYOS-CCTV-v4 default-action 'drop'
set firewall ipv4 name VYOS-CCTV-v4 description 'From VYOS to CCTV'
set firewall ipv4 name VYOS-CCTV-v4 enable-default-log
set firewall ipv4 name VYOS-CCTV-v4 rule 999 action 'drop'
set firewall ipv4 name VYOS-CCTV-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name VYOS-CCTV-v4 rule 999 state invalid 'enable'
set firewall ipv4 name VYOS-CCTV-v4 rule 999 log 'enable'

# From VYOS to CONTAINERS
set firewall ipv4 name VYOS-CONTAINERS-v4 default-action 'accept'
set firewall ipv4 name VYOS-CONTAINERS-v4 description 'From LOCAL to CONTAINERS'
set firewall ipv4 name VYOS-CONTAINERS-v4 rule 40 action 'accept'
set firewall ipv4 name VYOS-CONTAINERS-v4 rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name VYOS-CONTAINERS-v4 rule 40 destination port 'domain,domain-s'
set firewall ipv4 name VYOS-CONTAINERS-v4 rule 40 protocol 'tcp_udp'
set firewall ipv4 name VYOS-CONTAINERS-v4 rule 999 action 'drop'
set firewall ipv4 name VYOS-CONTAINERS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name VYOS-CONTAINERS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name VYOS-CONTAINERS-v4 rule 999 log 'enable'

# From VYOS to WAN
set firewall ipv4 name VYOS-WAN-v4 default-action 'accept'
set firewall ipv4 name VYOS-WAN-v4 description 'From VYOS to WAN'


############################################################################################################ 
# MANAGEMENT
############################################################################################################
# From MGMT to VYOS
set firewall ipv4 name MGMT-VYOS-v4 default-action 'drop'
set firewall ipv4 name MGMT-VYOS-v4 description 'From mgmt to VYOS'
set firewall ipv4 name MGMT-VYOS-v4 enable-default-log
set firewall ipv4 name MGMT-VYOS-v4 rule 50 action 'accept'
set firewall ipv4 name MGMT-VYOS-v4 rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name MGMT-VYOS-v4 rule 50 destination port '67,68'
set firewall ipv4 name MGMT-VYOS-v4 rule 50 protocol 'udp'
set firewall ipv4 name MGMT-VYOS-v4 rule 50 source port '67,68'
set firewall ipv4 name MGMT-VYOS-v4 rule 60 action 'accept'
set firewall ipv4 name MGMT-VYOS-v4 rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name MGMT-VYOS-v4 rule 60 destination port 'ntp'
set firewall ipv4 name MGMT-VYOS-v4 rule 60 protocol 'udp'
set firewall ipv4 name MGMT-VYOS-v4 rule 100 action 'accept'
set firewall ipv4 name MGMT-VYOS-v4 rule 100 description 'Rule: Accept_IGMP'
set firewall ipv4 name MGMT-VYOS-v4 rule 100 protocol '2'
set firewall ipv4 name MGMT-VYOS-v4 rule 110 action 'accept'
set firewall ipv4 name MGMT-VYOS-v4 rule 110 description 'Rule: Accept_MDNS'
set firewall ipv4 name MGMT-VYOS-v4 rule 110 destination port 'mdns'
set firewall ipv4 name MGMT-VYOS-v4 rule 110 protocol 'udp'
set firewall ipv4 name MGMT-VYOS-v4 rule 110 source port 'mdns'
set firewall ipv4 name MGMT-VYOS-v4 rule 400 action 'accept'
set firewall ipv4 name MGMT-VYOS-v4 rule 400 description 'Rule: Accept_SSH'
set firewall ipv4 name MGMT-VYOS-v4 rule 400 destination port 'ssh'
set firewall ipv4 name MGMT-VYOS-v4 rule 400 protocol 'tcp'
set firewall ipv4 name MGMT-VYOS-v4 rule 410 action 'accept'
set firewall ipv4 name MGMT-VYOS-v4 rule 410 description 'Rule: Accept_VyOS_API'
set firewall ipv4 name MGMT-VYOS-v4 rule 410 destination port '8443'
set firewall ipv4 name MGMT-VYOS-v4 rule 410 protocol 'tcp'
set firewall ipv4 name MGMT-VYOS-v4 rule 420 action 'accept'
set firewall ipv4 name MGMT-VYOS-v4 rule 420 description 'Rule: Accept_Wireguard'
set firewall ipv4 name MGMT-VYOS-v4 rule 420 destination port '51820'
set firewall ipv4 name MGMT-VYOS-v4 rule 420 protocol 'udp'
set firewall ipv4 name MGMT-VYOS-v4 rule 999 action 'drop'
set firewall ipv4 name MGMT-VYOS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name MGMT-VYOS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name MGMT-VYOS-v4 rule 999 log 'enable'

# From MGMT to INFRA
set firewall ipv4 name MGMT-INFRA-v4 default-action 'accept'
set firewall ipv4 name MGMT-INFRA-v4 description 'From MGMT to INFRA'
set firewall ipv4 name MGMT-INFRA-v4 rule 999 action 'drop'
set firewall ipv4 name MGMT-INFRA-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name MGMT-INFRA-v4 rule 999 state invalid 'enable'
set firewall ipv4 name MGMT-INFRA-v4 rule 999 log 'enable'

# From MGMT to HOME
set firewall ipv4 name MGMT-HOME-v4 default-action 'accept'
set firewall ipv4 name MGMT-HOME-v4 description 'From MGMT to HOME'
set firewall ipv4 name MGMT-HOME-v4 rule 999 action 'drop'
set firewall ipv4 name MGMT-HOME-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name MGMT-HOME-v4 rule 999 state invalid 'enable'
set firewall ipv4 name MGMT-HOME-v4 rule 999 log 'enable'

# From MGMT to IOT
set firewall ipv4 name MGMT-IOT-v4 default-action 'accept'
set firewall ipv4 name MGMT-IOT-v4 description 'From MGMT to IOT'
set firewall ipv4 name MGMT-IOT-v4 rule 999 action 'drop'
set firewall ipv4 name MGMT-IOT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name MGMT-IOT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name MGMT-IOT-v4 rule 999 log 'enable'

# From MGMT to CCTV
set firewall ipv4 name MGMT-CCTV-v4 default-action 'accept'
set firewall ipv4 name MGMT-CCTV-v4 description 'From MGMT to CCTV'
set firewall ipv4 name MGMT-CCTV-v4 rule 999 action 'drop'
set firewall ipv4 name MGMT-CCTV-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name MGMT-CCTV-v4 rule 999 state invalid 'enable'
set firewall ipv4 name MGMT-CCTV-v4 rule 999 log 'enable'

# From MGMT to CONTAINERS
set firewall ipv4 name MGMT-CONTAINERS-v4 default-action 'accept'
set firewall ipv4 name MGMT-CONTAINERS-v4 description 'From MGMT to CONTAINERS'
set firewall ipv4 name MGMT-CONTAINERS-v4 rule 40 action 'accept'
set firewall ipv4 name MGMT-CONTAINERS-v4 rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name MGMT-CONTAINERS-v4 rule 40 destination port 'domain,domain-s'
set firewall ipv4 name MGMT-CONTAINERS-v4 rule 40 protocol 'tcp_udp'
set firewall ipv4 name MGMT-CONTAINERS-v4 rule 999 action 'drop'
set firewall ipv4 name MGMT-CONTAINERS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name MGMT-CONTAINERS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name MGMT-CONTAINERS-v4 rule 999 log 'enable'

# From MGMT to WAN
set firewall ipv4 name MGMT-WAN-v4 default-action 'accept'
set firewall ipv4 name MGMT-WAN-v4 description 'From MGMT to WAN'

############################################################################################################ 
# INFRA
############################################################################################################
# From INFRA to VYOS
set firewall ipv4 name INFRA-VYOS-v4 default-action 'drop'
set firewall ipv4 name INFRA-VYOS-v4 description 'From INFRA to VYOS'
set firewall ipv4 name INFRA-VYOS-v4 enable-default-log
set firewall ipv4 name INFRA-VYOS-v4 rule 50 action 'accept'
set firewall ipv4 name INFRA-VYOS-v4 rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name INFRA-VYOS-v4 rule 50 destination port '67,68'
set firewall ipv4 name INFRA-VYOS-v4 rule 50 protocol 'udp'
set firewall ipv4 name INFRA-VYOS-v4 rule 50 source port '67,68'
set firewall ipv4 name INFRA-VYOS-v4 rule 60 action 'accept'
set firewall ipv4 name INFRA-VYOS-v4 rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name INFRA-VYOS-v4 rule 60 destination port 'ntp'
set firewall ipv4 name INFRA-VYOS-v4 rule 60 protocol 'udp'
set firewall ipv4 name INFRA-VYOS-v4 rule 70 action 'accept'
set firewall ipv4 name INFRA-VYOS-v4 rule 70 description 'Rule: Accept_BGP'
set firewall ipv4 name INFRA-VYOS-v4 rule 70 destination port 'bgp'
set firewall ipv4 name INFRA-VYOS-v4 rule 70 protocol 'tcp'
set firewall ipv4 name INFRA-VYOS-v4 rule 80 action 'accept'
set firewall ipv4 name INFRA-VYOS-v4 rule 80 description 'Rule: Accept_TFTP'
set firewall ipv4 name INFRA-VYOS-v4 rule 80 destination port '69'
set firewall ipv4 name INFRA-VYOS-v4 rule 80 protocol 'udp'
set firewall ipv4 name INFRA-VYOS-v4 rule 100 action 'accept'
set firewall ipv4 name INFRA-VYOS-v4 rule 100 description 'Rule: Accept_node_exporter_from_k8s_nodes'
set firewall ipv4 name INFRA-VYOS-v4 rule 100 destination port '9100'
set firewall ipv4 name INFRA-VYOS-v4 rule 100 protocol 'tcp'
set firewall ipv4 name INFRA-VYOS-v4 rule 100 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name INFRA-VYOS-v4 rule 110 action 'accept'
set firewall ipv4 name INFRA-VYOS-v4 rule 110 description 'Rule: Accept_speedtest_exporter_from_k8s_nodes'
set firewall ipv4 name INFRA-VYOS-v4 rule 110 destination port '9798'
set firewall ipv4 name INFRA-VYOS-v4 rule 110 protocol 'tcp'
set firewall ipv4 name INFRA-VYOS-v4 rule 110 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name INFRA-VYOS-v4 rule 999 action 'drop'
set firewall ipv4 name INFRA-VYOS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name INFRA-VYOS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name INFRA-VYOS-v4 rule 999 log 'enable'

# From INFRA to MGMT
set firewall ipv4 name INFRA-MGMT-v4 default-action 'drop'
set firewall ipv4 name INFRA-MGMT-v4 description 'From INFRA to MGMT'
set firewall ipv4 name INFRA-MGMT-v4 enable-default-log
set firewall ipv4 name INFRA-MGMT-v4 rule 999 action 'drop'
set firewall ipv4 name INFRA-MGMT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name INFRA-MGMT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name INFRA-MGMT-v4 rule 999 log 'enable'

# From INFRA to HOME
set firewall ipv4 name INFRA-HOME-v4 default-action 'drop'
set firewall ipv4 name INFRA-HOME-v4 description 'From INFRA to HOME'
set firewall ipv4 name INFRA-HOME-v4 enable-default-log
set firewall ipv4 name INFRA-HOME-v4 rule 999 action 'drop'
set firewall ipv4 name INFRA-HOME-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name INFRA-HOME-v4 rule 999 state invalid 'enable'
set firewall ipv4 name INFRA-HOME-v4 rule 999 log 'enable'

# From INFRA to IOT
set firewall ipv4 name INFRA-IOT-v4 default-action 'drop'
set firewall ipv4 name INFRA-IOT-v4 description 'From INFRA to IOT'
set firewall ipv4 name INFRA-IOT-v4 enable-default-log
set firewall ipv4 name INFRA-IOT-v4 rule 100 action 'accept'
set firewall ipv4 name INFRA-IOT-v4 rule 100 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name INFRA-IOT-v4 rule 100 protocol 'tcp'
set firewall ipv4 name INFRA-IOT-v4 rule 100 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name INFRA-IOT-v4 rule 110 action 'accept'
set firewall ipv4 name INFRA-IOT-v4 rule 110 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name INFRA-IOT-v4 rule 110 protocol 'icmp'
set firewall ipv4 name INFRA-IOT-v4 rule 110 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name INFRA-IOT-v4 rule 999 action 'drop'
set firewall ipv4 name INFRA-IOT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name INFRA-IOT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name INFRA-IOT-v4 rule 999 log 'enable'

# From INFRA to CCTV
set firewall ipv4 name INFRA-CCTV-v4 default-action 'drop'
set firewall ipv4 name INFRA-CCTV-v4 description 'From INFRA to CCTV'
set firewall ipv4 name INFRA-CCTV-v4 enable-default-log
set firewall ipv4 name INFRA-CCTV-v4 rule 100 action 'accept'
set firewall ipv4 name INFRA-CCTV-v4 rule 100 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name INFRA-CCTV-v4 rule 100 protocol 'tcp_udp'
set firewall ipv4 name INFRA-CCTV-v4 rule 100 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name INFRA-CCTV-v4 rule 999 action 'drop'
set firewall ipv4 name INFRA-CCTV-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name INFRA-CCTV-v4 rule 999 state invalid 'enable'
set firewall ipv4 name INFRA-CCTV-v4 rule 999 log 'enable'

# From INFRA to CONTAINERS
set firewall ipv4 name INFRA-CONTAINERS-v4 default-action 'accept'
set firewall ipv4 name INFRA-CONTAINERS-v4 description 'From INFRA to CONTAINERS'
set firewall ipv4 name INFRA-CONTAINERS-v4 enable-default-log
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 40 action 'accept'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 40 destination port 'domain,domain-s'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 40 protocol 'tcp_udp'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 100 action 'accept'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 100 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 100 protocol 'tcp'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 100 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 999 action 'drop'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name INFRA-CONTAINERS-v4 rule 999 log 'enable'

# From INFRA to WAN
set firewall ipv4 name INFRA-WAN-v4 default-action 'accept'
set firewall ipv4 name INFRA-WAN-v4 description 'From INFRA to WAN'

############################################################################################################ 
# HOME
############################################################################################################
# From HOME to VYOS
set firewall ipv4 name HOME-VYOS-v4 default-action 'drop'
set firewall ipv4 name HOME-VYOS-v4 description 'From HOME to VYOS'
set firewall ipv4 name HOME-VYOS-v4 enable-default-log
set firewall ipv4 name HOME-VYOS-v4 rule 50 action 'accept'
set firewall ipv4 name HOME-VYOS-v4 rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name HOME-VYOS-v4 rule 50 destination port '67,68'
set firewall ipv4 name HOME-VYOS-v4 rule 50 protocol 'udp'
set firewall ipv4 name HOME-VYOS-v4 rule 50 source port '67,68'
set firewall ipv4 name HOME-VYOS-v4 rule 60 action 'accept'
set firewall ipv4 name HOME-VYOS-v4 rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name HOME-VYOS-v4 rule 60 destination port 'ntp'
set firewall ipv4 name HOME-VYOS-v4 rule 60 protocol 'udp'
set firewall ipv4 name HOME-VYOS-v4 rule 999 action 'drop'
set firewall ipv4 name HOME-VYOS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name HOME-VYOS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name HOME-VYOS-v4 rule 999 log 'enable'

# From HOME to MGMT
set firewall ipv4 name HOME-MGMT-v4 default-action 'drop'
set firewall ipv4 name HOME-MGMT-v4 description 'From HOME to MGMT'
set firewall ipv4 name HOME-MGMT-v4 enable-default-log
set firewall ipv4 name HOME-MGMT-v4 rule 999 action 'drop'
set firewall ipv4 name HOME-MGMT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name HOME-MGMT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name HOME-MGMT-v4 rule 999 log 'enable'

# From HOME to INFRA
set firewall ipv4 name HOME-INFRA-v4 default-action 'drop'
set firewall ipv4 name HOME-INFRA-v4 description 'From HOME to INFRA'
set firewall ipv4 name HOME-INFRA-v4 enable-default-log
set firewall ipv4 name HOME-INFRA-v4 rule 999 action 'drop'
set firewall ipv4 name HOME-INFRA-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name HOME-INFRA-v4 rule 999 state invalid 'enable'
set firewall ipv4 name HOME-INFRA-v4 rule 999 log 'enable'

# From HOME to IOT
set firewall ipv4 name HOME-IOT-v4 default-action 'drop'
set firewall ipv4 name HOME-IOT-v4 description 'From HOME to IOT'
set firewall ipv4 name HOME-IOT-v4 enable-default-log
set firewall ipv4 name HOME-IOT-v4 rule 999 action 'drop'
set firewall ipv4 name HOME-IOT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name HOME-IOT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name HOME-IOT-v4 rule 999 log 'enable'

# From HOME to CCTV
set firewall ipv4 name HOME-CCTV-v4 default-action 'drop'
set firewall ipv4 name HOME-CCTV-v4 description 'From HOME to CCTV'
set firewall ipv4 name HOME-CCTV-v4 enable-default-log
set firewall ipv4 name HOME-CCTV-v4 rule 999 action 'drop'
set firewall ipv4 name HOME-CCTV-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name HOME-CCTV-v4 rule 999 state invalid 'enable'
set firewall ipv4 name HOME-CCTV-v4 rule 999 log 'enable'

# From HOME to CONTAINERS
set firewall ipv4 name HOME-CONTAINERS-v4 default-action 'accept'
set firewall ipv4 name HOME-CONTAINERS-v4 description 'From HOME to CONTAINERS'
set firewall ipv4 name HOME-CONTAINERS-v4 rule 40 action 'accept'
set firewall ipv4 name HOME-CONTAINERS-v4 rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name HOME-CONTAINERS-v4 rule 40 destination port 'domain,domain-s'
set firewall ipv4 name HOME-CONTAINERS-v4 rule 40 protocol 'tcp_udp'
set firewall ipv4 name HOME-CONTAINERS-v4 rule 999 action 'drop'
set firewall ipv4 name HOME-CONTAINERS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name HOME-CONTAINERS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name HOME-CONTAINERS-v4 rule 999 log 'enable'

# From HOME to WAN
set firewall ipv4 name HOME-WAN-v4 default-action 'accept'
set firewall ipv4 name HOME-WAN-v4 description 'From HOME to WAN'

############################################################################################################ 
# IOT
############################################################################################################
# From IOT to VYOS
set firewall ipv4 name IOT-VYOS-v4 default-action 'drop'
set firewall ipv4 name IOT-VYOS-v4 description 'From IOT to VYOS'
set firewall ipv4 name IOT-VYOS-v4 enable-default-log
set firewall ipv4 name IOT-VYOS-v4 rule 50 action 'accept'
set firewall ipv4 name IOT-VYOS-v4 rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name IOT-VYOS-v4 rule 50 destination port '67,68'
set firewall ipv4 name IOT-VYOS-v4 rule 50 protocol 'udp'
set firewall ipv4 name IOT-VYOS-v4 rule 50 source port '67,68'
set firewall ipv4 name IOT-VYOS-v4 rule 60 action 'accept'
set firewall ipv4 name IOT-VYOS-v4 rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name IOT-VYOS-v4 rule 60 destination port 'ntp'
set firewall ipv4 name IOT-VYOS-v4 rule 60 protocol 'udp'
set firewall ipv4 name IOT-VYOS-v4 rule 100 action 'accept'
set firewall ipv4 name IOT-VYOS-v4 rule 100 description 'Rule: Accept_IGMP'
set firewall ipv4 name IOT-VYOS-v4 rule 100 protocol '2'
set firewall ipv4 name IOT-VYOS-v4 rule 110 action 'accept'
set firewall ipv4 name IOT-VYOS-v4 rule 110 description 'Rule: Accept_MDNS'
set firewall ipv4 name IOT-VYOS-v4 rule 110 destination port 'mdns'
set firewall ipv4 name IOT-VYOS-v4 rule 110 protocol 'udp'
set firewall ipv4 name IOT-VYOS-v4 rule 110 source port 'mdns'
set firewall ipv4 name IOT-VYOS-v4 rule 999 action 'drop'
set firewall ipv4 name IOT-VYOS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name IOT-VYOS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name IOT-VYOS-v4 rule 999 log 'enable'

# From IOT to MGMT
set firewall ipv4 name IOT-MGMT-v4 default-action 'drop'
set firewall ipv4 name IOT-MGMT-v4 description 'From IOT to MGMT'
set firewall ipv4 name IOT-MGMT-v4 enable-default-log
set firewall ipv4 name IOT-MGMT-v4 rule 999 action 'drop'
set firewall ipv4 name IOT-MGMT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name IOT-MGMT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name IOT-MGMT-v4 rule 999 log 'enable'

# From IOT to INFRA
set firewall ipv4 name IOT-INFRA-v4 default-action 'drop'
set firewall ipv4 name IOT-INFRA-v4 description 'From IOT to infra'
set firewall ipv4 name IOT-INFRA-v4 enable-default-log
set firewall ipv4 name IOT-INFRA-v4 rule 100 action 'accept'
set firewall ipv4 name IOT-INFRA-v4 rule 100 description 'Rule: Accept_nas_smb_from_printers'
set firewall ipv4 name IOT-INFRA-v4 rule 100 destination group address-group 'FW_AG_NAS_ADDR'
set firewall ipv4 name IOT-INFRA-v4 rule 100 destination port 'microsoft-ds'
set firewall ipv4 name IOT-INFRA-v4 rule 100 protocol 'tcp'
set firewall ipv4 name IOT-INFRA-v4 rule 100 source group address-group 'FW_AG_PRINTER_ADDR'
set firewall ipv4 name IOT-INFRA-v4 rule 200 action 'accept'
set firewall ipv4 name IOT-INFRA-v4 rule 200 description 'Rule: Accept_plex_from_plex_clients'
set firewall ipv4 name IOT-INFRA-v4 rule 200 destination group address-group 'FW_AG_K8S_PLEX_SVC'
set firewall ipv4 name IOT-INFRA-v4 rule 200 destination port '32400'
set firewall ipv4 name IOT-INFRA-v4 rule 200 protocol 'tcp'
set firewall ipv4 name IOT-INFRA-v4 rule 200 source group address-group 'FW_AG_PLEX_CLIENTS_IOT'
set firewall ipv4 name IOT-INFRA-v4 rule 300 action 'accept'
set firewall ipv4 name IOT-INFRA-v4 rule 300 description 'Rule: Accept_mqtt_from_mqtt_clients'
set firewall ipv4 name IOT-INFRA-v4 rule 300 destination group address-group 'FW_AG_K8S_MQTT_SVC'
set firewall ipv4 name IOT-INFRA-v4 rule 300 destination port '1883'
set firewall ipv4 name IOT-INFRA-v4 rule 300 protocol 'tcp'
set firewall ipv4 name IOT-INFRA-v4 rule 300 source group address-group 'FW_AG_MQTT_CLIENTS_IOT'
set firewall ipv4 name IOT-INFRA-v4 rule 410 action 'accept'
set firewall ipv4 name IOT-INFRA-v4 rule 410 description 'Rule: Accept_k8s_ingress_from_allowed_devices'
set firewall ipv4 name IOT-INFRA-v4 rule 410 destination group address-group 'FW_AG_K8S_INGRESS_SVC'
set firewall ipv4 name IOT-INFRA-v4 rule 410 destination port 'http,https'
set firewall ipv4 name IOT-INFRA-v4 rule 410 protocol 'tcp'
set firewall ipv4 name IOT-INFRA-v4 rule 410 source group network-group 'FW_NG_IOT'
set firewall ipv4 name IOT-INFRA-v4 rule 999 action 'drop'
set firewall ipv4 name IOT-INFRA-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name IOT-INFRA-v4 rule 999 state invalid 'enable'
set firewall ipv4 name IOT-INFRA-v4 rule 999 log 'enable'

# From IOT to HOME
set firewall ipv4 name IOT-HOME-v4 default-action 'drop'
set firewall ipv4 name IOT-HOME-v4 description 'From IOT to HOME'
set firewall ipv4 name IOT-HOME-v4 enable-default-log
set firewall ipv4 name IOT-HOME-v4 rule 999 action 'drop'
set firewall ipv4 name IOT-HOME-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name IOT-HOME-v4 rule 999 state invalid 'enable'
set firewall ipv4 name IOT-HOME-v4 rule 999 log 'enable'

# From IOT to CCTV
set firewall ipv4 name IOT-CCTV-v4 default-action 'drop'
set firewall ipv4 name IOT-CCTV-v4 description 'From IOT to CCTV'
set firewall ipv4 name IOT-CCTV-v4 enable-default-log
set firewall ipv4 name IOT-CCTV-v4 rule 100 action 'accept'
set firewall ipv4 name IOT-CCTV-v4 rule 100 description 'Rule: Accept_k8s_iot_nodes_tcp'
set firewall ipv4 name IOT-CCTV-v4 rule 100 protocol 'tcp'
set firewall ipv4 name IOT-CCTV-v4 rule 100 source group address-group 'FW_AG_K8S_WORKER_IOT_ADDR'
set firewall ipv4 name IOT-CCTV-v4 rule 101 action 'accept'
set firewall ipv4 name IOT-CCTV-v4 rule 101 description 'Rule: Accept_k8s_iot_nodes_udp'
set firewall ipv4 name IOT-CCTV-v4 rule 101 protocol 'udp'
set firewall ipv4 name IOT-CCTV-v4 rule 101 source group address-group 'FW_AG_K8S_WORKER_IOT_ADDR'
set firewall ipv4 name IOT-CCTV-v4 rule 999 action 'drop'
set firewall ipv4 name IOT-CCTV-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name IOT-CCTV-v4 rule 999 state invalid 'enable'
set firewall ipv4 name IOT-CCTV-v4 rule 999 log 'enable'

# From IOT to CONTAINERS
set firewall ipv4 name IOT-CONTAINERS-v4 default-action 'accept'
set firewall ipv4 name IOT-CONTAINERS-v4 description 'From IOT to CONTAINERS'
set firewall ipv4 name IOT-CONTAINERS-v4 rule 40 action 'accept'
set firewall ipv4 name IOT-CONTAINERS-v4 rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name IOT-CONTAINERS-v4 rule 40 destination port 'domain,domain-s'
set firewall ipv4 name IOT-CONTAINERS-v4 rule 40 protocol 'tcp_udp'
set firewall ipv4 name IOT-CONTAINERS-v4 rule 999 action 'drop'
set firewall ipv4 name IOT-CONTAINERS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name IOT-CONTAINERS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name IOT-CONTAINERS-v4 rule 999 log 'enable'

# From IOT to WAN
set firewall ipv4 name IOT-WAN-v4 default-action 'accept'
set firewall ipv4 name IOT-WAN-v4 description 'From IOT to WAN'


############################################################################################################ 
# CCTV
############################################################################################################
# From CCTV to VYOS
set firewall ipv4 name CCTV-VYOS-v4 default-action 'drop'
set firewall ipv4 name CCTV-VYOS-v4 description 'From CCTV to VYOS'
set firewall ipv4 name CCTV-VYOS-v4 enable-default-log
set firewall ipv4 name CCTV-VYOS-v4 rule 50 action 'accept'
set firewall ipv4 name CCTV-VYOS-v4 rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name CCTV-VYOS-v4 rule 50 destination port '67,68'
set firewall ipv4 name CCTV-VYOS-v4 rule 50 protocol 'udp'
set firewall ipv4 name CCTV-VYOS-v4 rule 50 source port '67,68'
set firewall ipv4 name CCTV-VYOS-v4 rule 60 action 'accept'
set firewall ipv4 name CCTV-VYOS-v4 rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name CCTV-VYOS-v4 rule 60 destination port 'ntp'
set firewall ipv4 name CCTV-VYOS-v4 rule 60 protocol 'udp'
set firewall ipv4 name CCTV-VYOS-v4 rule 999 action 'drop'
set firewall ipv4 name CCTV-VYOS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CCTV-VYOS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CCTV-VYOS-v4 rule 999 log 'enable'

# From CCTV to MGMT
set firewall ipv4 name CCTV-MGMT-v4 default-action 'drop'
set firewall ipv4 name CCTV-MGMT-v4 description 'From CCTV to MGMT'
set firewall ipv4 name CCTV-MGMT-v4 enable-default-log
set firewall ipv4 name CCTV-MGMT-v4 rule 999 action 'drop'
set firewall ipv4 name CCTV-MGMT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CCTV-MGMT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CCTV-MGMT-v4 rule 999 log 'enable'

# From CCTV to INFRA
set firewall ipv4 name CCTV-INFRA-v4 default-action 'drop'
set firewall ipv4 name CCTV-INFRA-v4 description 'From CCTV to INFRA'
set firewall ipv4 name CCTV-INFRA-v4 enable-default-log
set firewall ipv4 name CCTV-INFRA-v4 rule 100 action 'accept'
set firewall ipv4 name CCTV-INFRA-v4 rule 100 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name CCTV-INFRA-v4 rule 100 protocol 'udp'
set firewall ipv4 name CCTV-INFRA-v4 rule 100 destination group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name CCTV-INFRA-v4 rule 100 source port '6987-6989'
set firewall ipv4 name CCTV-INFRA-v4 rule 999 action 'drop'
set firewall ipv4 name CCTV-INFRA-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CCTV-INFRA-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CCTV-INFRA-v4 rule 999 log 'enable'

# From CCTV to HOME
set firewall ipv4 name CCTV-HOME-v4 default-action 'drop'
set firewall ipv4 name CCTV-HOME-v4 description 'From CCTV to HOME'
set firewall ipv4 name CCTV-HOME-v4 enable-default-log
set firewall ipv4 name CCTV-HOME-v4 rule 999 action 'drop'
set firewall ipv4 name CCTV-HOME-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CCTV-HOME-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CCTV-HOME-v4 rule 999 log 'enable'

# From CCTV to IOT
set firewall ipv4 name CCTV-IOT-v4 default-action 'drop'
set firewall ipv4 name CCTV-IOT-v4 description 'From CCTV to IOT'
set firewall ipv4 name CCTV-IOT-v4 enable-default-log
set firewall ipv4 name CCTV-IOT-v4 rule 100 action 'accept'
set firewall ipv4 name CCTV-IOT-v4 rule 100 description 'Rule: allow connecting to hass'
set firewall ipv4 name CCTV-IOT-v4 rule 100 protocol 'tcp'
set firewall ipv4 name CCTV-IOT-v4 rule 100 destination group address-group 'FW_AG_K8S_HASS_SVC'
set firewall ipv4 name CCTV-IOT-v4 rule 100 destination port '8123'
set firewall ipv4 name CCTV-IOT-v4 rule 999 action 'drop'
set firewall ipv4 name CCTV-IOT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CCTV-IOT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CCTV-IOT-v4 rule 999 log 'enable'

# From CCTV to CONTAINERS
set firewall ipv4 name CCTV-CONTAINERS-v4 default-action 'accept'
set firewall ipv4 name CCTV-CONTAINERS-v4 description 'From CCTV to CONTAINERS'
set firewall ipv4 name CCTV-CONTAINERS-v4 rule 40 action 'accept'
set firewall ipv4 name CCTV-CONTAINERS-v4 rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name CCTV-CONTAINERS-v4 rule 40 destination port 'domain,domain-s'
set firewall ipv4 name CCTV-CONTAINERS-v4 rule 40 protocol 'tcp_udp'
set firewall ipv4 name CCTV-CONTAINERS-v4 rule 999 action 'drop'
set firewall ipv4 name CCTV-CONTAINERS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CCTV-CONTAINERS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CCTV-CONTAINERS-v4 rule 999 log 'enable'

# From CCTV to WAN
set firewall ipv4 name CCTV-WAN-v4 default-action 'drop'
set firewall ipv4 name CCTV-WAN-v4 description 'From CCTV to WAN'

############################################################################################################ 
# CONTAINERS
############################################################################################################
# From CONTAINERS to VYOS
set firewall ipv4 name CONTAINERS-VYOS-v4 default-action 'drop'
set firewall ipv4 name CONTAINERS-VYOS-v4 description 'From CONTAINERS to VYOS'
set firewall ipv4 name CONTAINERS-VYOS-v4 enable-default-log
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 50 action 'accept'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 50 destination port '67,68'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 50 protocol 'udp'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 50 source port '67,68'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 60 action 'accept'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 60 destination port 'ntp'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 60 protocol 'udp'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 999 action 'drop'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CONTAINERS-VYOS-v4 rule 999 log 'enable'

# From CONTAINERS to MGMT
set firewall ipv4 name CONTAINERS-MGMT-v4 default-action 'drop'
set firewall ipv4 name CONTAINERS-MGMT-v4 description 'From CONTAINERS to MGMT'
set firewall ipv4 name CONTAINERS-MGMT-v4 enable-default-log
set firewall ipv4 name CONTAINERS-MGMT-v4 rule 999 action 'drop'
set firewall ipv4 name CONTAINERS-MGMT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CONTAINERS-MGMT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CONTAINERS-MGMT-v4 rule 999 log 'enable'

# From CONTAINERS to INFRA
set firewall ipv4 name CONTAINERS-INFRA-v4 default-action 'accept'
set firewall ipv4 name CONTAINERS-INFRA-v4 description 'From CONTAINERS to INFRA'
set firewall ipv4 name CONTAINERS-INFRA-v4 rule 999 action 'drop'
set firewall ipv4 name CONTAINERS-INFRA-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CONTAINERS-INFRA-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CONTAINERS-INFRA-v4 rule 999 log 'enable'

# From CONTAINERS to HOME
set firewall ipv4 name CONTAINERS-HOME-v4 default-action 'drop'
set firewall ipv4 name CONTAINERS-HOME-v4 description 'From CONTAINERS to HOME'
set firewall ipv4 name CONTAINERS-HOME-v4 enable-default-log
set firewall ipv4 name CONTAINERS-HOME-v4 rule 999 action 'drop'
set firewall ipv4 name CONTAINERS-HOME-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CONTAINERS-HOME-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CONTAINERS-HOME-v4 rule 999 log 'enable'

# From CONTAINERS to IOT
set firewall ipv4 name CONTAINERS-IOT-v4 default-action 'drop'
set firewall ipv4 name CONTAINERS-IOT-v4 description 'From CONTAINERS to IOT'
set firewall ipv4 name CONTAINERS-IOT-v4 enable-default-log
set firewall ipv4 name CONTAINERS-IOT-v4 rule 999 action 'drop'
set firewall ipv4 name CONTAINERS-IOT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CONTAINERS-IOT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CONTAINERS-IOT-v4 rule 999 log 'enable'

# From CONTAINERS to CCTV
set firewall ipv4 name CONTAINERS-CCTV-v4 default-action 'drop'
set firewall ipv4 name CONTAINERS-CCTV-v4 description 'From CONTAINERS to CCTV'
set firewall ipv4 name CONTAINERS-CCTV-v4 enable-default-log
set firewall ipv4 name CONTAINERS-CCTV-v4 rule 999 action 'drop'
set firewall ipv4 name CONTAINERS-CCTV-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name CONTAINERS-CCTV-v4 rule 999 state invalid 'enable'
set firewall ipv4 name CONTAINERS-CCTV-v4 rule 999 log 'enable'

# From CONTAINERS to WAN
set firewall ipv4 name CONTAINERS-WAN-v4 default-action 'accept'
set firewall ipv4 name CONTAINERS-WAN-v4 description 'From CONTAINERS to WAN'


############################################################################################################ 
# WAN
############################################################################################################
# From WAN to VYOS
set firewall ipv4 name WAN-VYOS-v4 default-action 'drop'
set firewall ipv4 name WAN-VYOS-v4 description 'From WAN to VYOS'
set firewall ipv4 name WAN-VYOS-v4 enable-default-log
set firewall ipv4 name WAN-VYOS-v4 rule 1 action 'drop'
set firewall ipv4 name WAN-VYOS-v4 rule 1 description 'Rule: Drop_Invalid'
set firewall ipv4 name WAN-VYOS-v4 rule 1 state invalid 'enable'
set firewall ipv4 name WAN-VYOS-v4 rule 1 log 'enable'
set firewall ipv4 name WAN-VYOS-v4 rule 100 action 'accept'
set firewall ipv4 name WAN-VYOS-v4 rule 100 description 'Rule: Accept_wireguard'
set firewall ipv4 name WAN-VYOS-v4 rule 100 destination port '51820'
set firewall ipv4 name WAN-VYOS-v4 rule 100 protocol 'udp'

# From WAN to MGMT
set firewall ipv4 name WAN-MGMT-v4 default-action 'drop'
set firewall ipv4 name WAN-MGMT-v4 description 'From WAN to MGMT'
set firewall ipv4 name WAN-MGMT-v4 enable-default-log
set firewall ipv4 name WAN-MGMT-v4 rule 999 action 'drop'
set firewall ipv4 name WAN-MGMT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name WAN-MGMT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name WAN-MGMT-v4 rule 999 log 'enable'

# From WAN to INFRA
set firewall ipv4 name WAN-INFRA-v4 default-action 'drop'
set firewall ipv4 name WAN-INFRA-v4 description 'From WAN to INFRA'
set firewall ipv4 name WAN-INFRA-v4 enable-default-log
set firewall ipv4 name WAN-INFRA-v4 rule 999 action 'drop'
set firewall ipv4 name WAN-INFRA-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name WAN-INFRA-v4 rule 999 state invalid 'enable'
set firewall ipv4 name WAN-INFRA-v4 rule 999 log 'enable'

# From WAN to HOME
set firewall ipv4 name WAN-HOME-v4 default-action 'drop'
set firewall ipv4 name WAN-HOME-v4 description 'From WAN to HOME'
set firewall ipv4 name WAN-HOME-v4 enable-default-log
set firewall ipv4 name WAN-HOME-v4 rule 999 action 'drop'
set firewall ipv4 name WAN-HOME-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name WAN-HOME-v4 rule 999 state invalid 'enable'
set firewall ipv4 name WAN-HOME-v4 rule 999 log 'enable'

# From WAN to IOT
set firewall ipv4 name WAN-IOT-v4 default-action 'drop'
set firewall ipv4 name WAN-IOT-v4 description 'From WAN to IOT'
set firewall ipv4 name WAN-IOT-v4 enable-default-log
set firewall ipv4 name WAN-IOT-v4 rule 999 action 'drop'
set firewall ipv4 name WAN-IOT-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name WAN-IOT-v4 rule 999 state invalid 'enable'
set firewall ipv4 name WAN-IOT-v4 rule 999 log 'enable'

# From WAN to CCTV
set firewall ipv4 name WAN-CCTV-v4 default-action 'drop'
set firewall ipv4 name WAN-CCTV-v4 description 'From WAN to CCTV'
set firewall ipv4 name WAN-CCTV-v4 enable-default-log
set firewall ipv4 name WAN-CCTV-v4 rule 999 action 'drop'
set firewall ipv4 name WAN-CCTV-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name WAN-CCTV-v4 rule 999 state invalid 'enable'
set firewall ipv4 name WAN-CCTV-v4 rule 999 log 'enable'

# From WAN to CONTAINERS
set firewall ipv4 name WAN-CONTAINERS-v4 default-action 'drop'
set firewall ipv4 name WAN-CONTAINERS-v4 description 'From WAN to CONTAINERS'
set firewall ipv4 name WAN-CONTAINERS-v4 enable-default-log
set firewall ipv4 name WAN-CONTAINERS-v4 rule 999 action 'drop'
set firewall ipv4 name WAN-CONTAINERS-v4 rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name WAN-CONTAINERS-v4 rule 999 state invalid 'enable'
set firewall ipv4 name WAN-CONTAINERS-v4 rule 999 log 'enable'

