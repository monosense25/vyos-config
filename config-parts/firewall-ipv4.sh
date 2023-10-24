#!/bin/vbash

# Configure forward filter:
#   forward_rule <rule_number> <inbound_interface_group> <outbound_interface_group> accept
#   forward_rule <rule_number> <inbound_interface_group> <outbound_interface_group> jump
#   forward_rule <rule_number> ignored <outbound_interface_group> drop
#
# interface_group do not have IG_ prefix - that is substituted
#
# jump target is <inbound>-<outbound> named rule
#
forward_rule_number=101
function forward_rule {
  rule=$((forward_rule_number))
  inbound=$1
  outbound=$2
  action=$3

  case $action in
    accept)
      set firewall ipv4 forward filter rule $rule action $action
      set firewall ipv4 forward filter rule $rule inbound-interface interface-group IG_$inbound
      set firewall ipv4 forward filter rule $rule outbound-interface interface-group IG_$outbound
      ;;
    drop)
      set firewall ipv4 forward filter rule $rule action $action
      set firewall ipv4 forward filter rule $rule outbound-interface interface-group IG_$outbound
      set firewall ipv4 forward filter rule $rule log 'enable'
      ;;
    jump)
      set firewall ipv4 forward filter rule $rule action $action
      set firewall ipv4 forward filter rule $rule inbound-interface interface-group IG_$inbound
      set firewall ipv4 forward filter rule $rule outbound-interface interface-group IG_$outbound
      set firewall ipv4 forward filter rule $rule jump-target ${inbound}-${outbound}
      ;;
  esac

  forward_rule_number=$((forward_rule_number+5))
}

# Configure input filter
#   input_rule <rule_number> <inbound_interface_group> jump
#   input_rule <rule_number> any drop
#
# interface_group do not have IG_ prefix - that is substituted
#
# jump target is <inbound>-local named rule
#
input_rule_number=101
function input_rule {
  rule=$((input_rule_number))
  inbound=$1
  action=$2

  case $action in
    drop)
      set firewall ipv4 input filter rule $rule action $action
      set firewall ipv4 input filter rule $rule log 'enable'
      ;;
    jump)
      set firewall ipv4 input filter rule $rule action $action
      set firewall ipv4 input filter rule $rule inbound-interface interface-group IG_$inbound
      set firewall ipv4 input filter rule $rule jump-target ${inbound}-local
      ;;
  esac

  input_rule_number=$((input_rule_number+5))
}

# Configure output filter
#   output_rule <rule_number> <outbound_interface_group> jump
#   output_rule <rule_number> any drop
#
# interface_group do not have IG_ prefix - that is substituted
#
# jump target is local-<outbound> named rule
#
output_rule_number=101
function output_rule {
  rule=$((output_rule_number))
  outbound=$1
  action=$2

  case $action in
    drop)
      set firewall ipv4 output filter rule $rule action $action
      set firewall ipv4 output filter rule $rule log 'enable'
      ;;
    jump)
      set firewall ipv4 output filter rule $rule action $action
      set firewall ipv4 output filter rule $rule outbound-interface interface-group IG_$outbound
      set firewall ipv4 output filter rule $rule jump-target local-$outbound
      ;;
  esac

  output_rule_number=$((output_rule_number+5))
}

function begin_traffic {
  shift # Ignore $1 which is "to"
  interface=$1

  if ! test "$interface" == "local"; then
    forward_rule $interface $interface accept
  fi
}

function handle_traffic {
  shift # Ignore $1 which is to
  outbound=$1
  shift
  shift # Ignore next word which is from
  for inbound in $*; do
    if test "$outbound" == "local"; then
      input_rule $inbound jump
    elif test "$inbound" == "local"; then
      output_rule $outbound jump
    else
      forward_rule $inbound $outbound jump
    fi
  done
}

function end_traffic {
  shift # Ignore $1 which is "to"
  outbound=$1

  if test "$outbound" == "local"; then
    input_rule any drop
    output_rule any drop
  else
    forward_rule any $outbound drop
  fi
}

# Default forward policy
set firewall ipv4 forward filter default-action 'accept'
set firewall ipv4 forward filter rule 1 action 'accept'
set firewall ipv4 forward filter rule 1 state established 'enable'
set firewall ipv4 forward filter rule 2 action 'accept'
set firewall ipv4 forward filter rule 2 state related 'enable'

# Default input policy
set firewall ipv4 input filter default-action 'accept'
set firewall ipv4 input filter rule 1 action 'accept'
set firewall ipv4 input filter rule 1 state established 'enable'
set firewall ipv4 input filter rule 2 action 'accept'
set firewall ipv4 input filter rule 2 state related 'enable'

# Default output policy
set firewall ipv4 output filter default-action 'accept'
set firewall ipv4 output filter rule 1 action 'accept'
set firewall ipv4 output filter rule 1 state established 'enable'
set firewall ipv4 output filter rule 2 action 'accept'
set firewall ipv4 output filter rule 2 state related 'enable'

# Ensure VyOS can talk to itself
set firewall ipv4 output filter rule 10 action accept
set firewall ipv4 output filter rule 10 source group address-group FW_AG_ROUTER_ADDR_IPV4
set firewall ipv4 output filter rule 10 destination group address-group FW_AG_ROUTER_ADDR_IPV4
set firewall ipv4 input  filter rule 10 action accept
set firewall ipv4 input  filter rule 10 source group address-group FW_AG_ROUTER_ADDR_IPV4
set firewall ipv4 input  filter rule 10 destination group address-group FW_AG_ROUTER_ADDR_IPV4

begin_traffic  to local
handle_traffic to local from mgmt infra home iot cctv containers wan
end_traffic    to local

begin_traffic  to mgmt
handle_traffic to mgmt from local infra home iot cctv containers wan
end_traffic    to mgmt

begin_traffic  to infra
handle_traffic to infra from local mgmt home iot cctv containers wan
end_traffic    to infra

begin_traffic  to home
handle_traffic to home from local mgmt infra iot cctv containers wan
end_traffic    to home

begin_traffic  to iot
handle_traffic to iot from local mgmt infra home cctv containers wan
end_traffic    to iot

begin_traffic  to cctv
handle_traffic to cctv from local mgmt infra home iot containers wan
end_traffic    to cctv

begin_traffic  to containers
handle_traffic to containers local mgmt infra home iot cctv wan 
end_traffic    to containers

begin_traffic  to wan
handle_traffic to wan from local mgmt infra home iot cctv containers
end_traffic    to wan

############################################################################################################ 
# VYOS / LOCAL
############################################################################################################
# From VYOS to MGMT
set firewall ipv4 name local-mgmt default-action 'drop'
set firewall ipv4 name local-mgmt description 'From LOCAL to MGMT'
set firewall ipv4 name local-mgmt enable-default-log
set firewall ipv4 name local-mgmt rule 100 action 'accept'
set firewall ipv4 name local-mgmt rule 100 description 'Rule: Accept_IGMP'
set firewall ipv4 name local-mgmt rule 100 protocol '2'
set firewall ipv4 name local-mgmt rule 110 action 'accept'
set firewall ipv4 name local-mgmt rule 110 description 'Rule: Accept_MDNS'
set firewall ipv4 name local-mgmt rule 110 destination port 'mdns'
set firewall ipv4 name local-mgmt rule 110 protocol 'udp'
set firewall ipv4 name local-mgmt rule 110 source port 'mdns'
set firewall ipv4 name local-mgmt rule 400 action 'accept'
set firewall ipv4 name local-mgmt rule 400 description 'Rule: Accept_wireguard'
set firewall ipv4 name local-mgmt rule 400 source port '51820'
set firewall ipv4 name local-mgmt rule 400 protocol 'udp'
set firewall ipv4 name local-mgmt rule 999 action 'drop'
set firewall ipv4 name local-mgmt rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name local-mgmt rule 999 state invalid 'enable'
set firewall ipv4 name local-mgmt rule 999 log 'enable'

# From VYOS to INFRA
set firewall ipv4 name local-infra default-action 'drop'
set firewall ipv4 name local-infra description 'From VYOS to INFRA'
set firewall ipv4 name local-infra enable-default-log
set firewall ipv4 name local-infra rule 40 action 'accept'
set firewall ipv4 name local-infra rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name local-infra rule 40 destination port 'domain,domain-s'
set firewall ipv4 name local-infra rule 40 protocol 'tcp_udp'
set firewall ipv4 name local-infra rule 70 action 'accept'
set firewall ipv4 name local-infra rule 70 description 'Rule: Accept_BGP'
set firewall ipv4 name local-infra rule 70 destination port 'bgp'
set firewall ipv4 name local-infra rule 70 protocol 'tcp'
set firewall ipv4 name local-infra rule 100 action 'accept'
set firewall ipv4 name local-infra rule 100 description 'Rule: Accept_k8s_api'
set firewall ipv4 name local-infra rule 100 destination port '6443'
set firewall ipv4 name local-infra rule 100 protocol 'tcp'
set firewall ipv4 name local-infra rule 200 action 'accept'
set firewall ipv4 name local-infra rule 200 description 'Rule: Accept_vector_syslog'
set firewall ipv4 name local-infra rule 200 destination group address-group 'FW_AG_K8S_VECTOR_SVC'
set firewall ipv4 name local-infra rule 200 destination port '6001'
set firewall ipv4 name local-infra rule 200 protocol 'tcp'
set firewall ipv4 name local-infra rule 999 action 'drop'
set firewall ipv4 name local-infra rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name local-infra rule 999 state invalid 'enable'
set firewall ipv4 name local-infra rule 999 log 'enable'

# From VYOS to HOME
set firewall ipv4 name local-home default-action 'drop'
set firewall ipv4 name local-home description 'From VYOS to HOME'
set firewall ipv4 name local-home enable-default-log
set firewall ipv4 name local-home rule 999 action 'drop'
set firewall ipv4 name local-homehome rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name local-home rule 999 state invalid 'enable'
set firewall ipv4 name local-home rule 999 log 'enable'

# From VYOS to IOT
set firewall ipv4 name local-iot default-action 'drop'
set firewall ipv4 name local-iot description 'From VYOS to IOT'
set firewall ipv4 name local-iot enable-default-log
set firewall ipv4 name local-iot rule 100 action 'accept'
set firewall ipv4 name local-iot rule 100 description 'Rule: Accept_IGMP'
set firewall ipv4 name local-iot rule 100 protocol '2'
set firewall ipv4 name local-iot rule 110 action 'accept'
set firewall ipv4 name local-iot rule 110 description 'Rule: Accept_MDNS'
set firewall ipv4 name local-iot rule 110 destination port 'mdns'
set firewall ipv4 name local-iot rule 110 protocol 'udp'
set firewall ipv4 name local-iot rule 110 source port 'mdns'
set firewall ipv4 name local-iot rule 999 action 'drop'
set firewall ipv4 name local-iot rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name local-iot rule 999 state invalid 'enable'
set firewall ipv4 name local-iot rule 999 log 'enable'

# From VYOS to CCTV
set firewall ipv4 name local-cctv default-action 'drop'
set firewall ipv4 name local-cctv description 'From VYOS to CCTV'
set firewall ipv4 name local-cctv enable-default-log
set firewall ipv4 name local-cctv rule 999 action 'drop'
set firewall ipv4 name local-cctv rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name local-cctv rule 999 state invalid 'enable'
set firewall ipv4 name local-cctv rule 999 log 'enable'

# From VYOS to CONTAINERS
set firewall ipv4 name local-containers default-action 'accept'
set firewall ipv4 name local-containers description 'From LOCAL to CONTAINERS'
set firewall ipv4 name local-containers rule 40 action 'accept'
set firewall ipv4 name local-containers rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name local-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name local-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name local-containers rule 999 action 'drop'
set firewall ipv4 name local-containers rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name local-containers rule 999 state invalid 'enable'
set firewall ipv4 name local-containers rule 999 log 'enable'

# From VYOS to WAN
set firewall ipv4 name local-wan default-action 'accept'
set firewall ipv4 name local-wan description 'From VYOS to WAN'


############################################################################################################ 
# MANAGEMENT
############################################################################################################
# From MGMT to VYOS
set firewall ipv4 name mgmt-local default-action 'drop'
set firewall ipv4 name mgmt-local description 'From mgmt to VYOS'
set firewall ipv4 name mgmt-local enable-default-log
set firewall ipv4 name mgmt-local rule 50 action 'accept'
set firewall ipv4 name mgmt-local rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name mgmt-local rule 50 destination port '67,68'
set firewall ipv4 name mgmt-local rule 50 protocol 'udp'
set firewall ipv4 name mgmt-local rule 50 source port '67,68'
set firewall ipv4 name mgmt-local rule 60 action 'accept'
set firewall ipv4 name mgmt-local rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name mgmt-local rule 60 destination port 'ntp'
set firewall ipv4 name mgmt-local rule 60 protocol 'udp'
set firewall ipv4 name mgmt-local rule 100 action 'accept'
set firewall ipv4 name mgmt-local rule 100 description 'Rule: Accept_IGMP'
set firewall ipv4 name mgmt-local rule 100 protocol '2'
set firewall ipv4 name mgmt-local rule 110 action 'accept'
set firewall ipv4 name mgmt-local rule 110 description 'Rule: Accept_MDNS'
set firewall ipv4 name mgmt-local rule 110 destination port 'mdns'
set firewall ipv4 name mgmt-local rule 110 protocol 'udp'
set firewall ipv4 name mgmt-local rule 110 source port 'mdns'
set firewall ipv4 name mgmt-local rule 400 action 'accept'
set firewall ipv4 name mgmt-local rule 400 description 'Rule: Accept_SSH'
set firewall ipv4 name mgmt-local rule 400 destination port 'ssh'
set firewall ipv4 name mgmt-local rule 400 protocol 'tcp'
set firewall ipv4 name mgmt-local rule 410 action 'accept'
set firewall ipv4 name mgmt-local rule 410 description 'Rule: Accept_VyOS_API'
set firewall ipv4 name mgmt-local rule 410 destination port '8443'
set firewall ipv4 name mgmt-local rule 410 protocol 'tcp'
set firewall ipv4 name mgmt-local rule 420 action 'accept'
set firewall ipv4 name mgmt-local rule 420 description 'Rule: Accept_Wireguard'
set firewall ipv4 name mgmt-local rule 420 destination port '51820'
set firewall ipv4 name mgmt-local rule 420 protocol 'udp'
set firewall ipv4 name mgmt-local rule 999 action 'drop'
set firewall ipv4 name mgmt-local rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name mgmt-local rule 999 state invalid 'enable'
set firewall ipv4 name mgmt-local rule 999 log 'enable'

# From MGMT to INFRA
set firewall ipv4 name mgmt-infra default-action 'accept'
set firewall ipv4 name mgmt-infra description 'From MGMT to INFRA'
set firewall ipv4 name mgmt-infra rule 999 action 'drop'
set firewall ipv4 name mgmt-infra rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name mgmt-infra rule 999 state invalid 'enable'
set firewall ipv4 name mgmt-infra rule 999 log 'enable'

# From MGMT to HOME
set firewall ipv4 name mgmt-home default-action 'accept'
set firewall ipv4 name mgmt-home description 'From MGMT to HOME'
set firewall ipv4 name mgmt-home rule 999 action 'drop'
set firewall ipv4 name mgmt-home rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name mgmt-home rule 999 state invalid 'enable'
set firewall ipv4 name mgmt-home rule 999 log 'enable'

# From MGMT to IOT
set firewall ipv4 name mgmt-iot default-action 'accept'
set firewall ipv4 name mgmt-iot description 'From MGMT to IOT'
set firewall ipv4 name mgmt-iot rule 999 action 'drop'
set firewall ipv4 name mgmt-iot rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name mgmt-iot rule 999 state invalid 'enable'
set firewall ipv4 name mgmt-iot rule 999 log 'enable'

# From MGMT to CCTV
set firewall ipv4 name mgmt-cctv default-action 'accept'
set firewall ipv4 name mgmt-cctv description 'From MGMT to CCTV'
set firewall ipv4 name mgmt-cctv rule 999 action 'drop'
set firewall ipv4 name mgmt-cctv rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name mgmt-cctv rule 999 state invalid 'enable'
set firewall ipv4 name mgmt-cctv rule 999 log 'enable'

# From MGMT to CONTAINERS
set firewall ipv4 name mgmt-containers default-action 'accept'
set firewall ipv4 name mgmt-containers description 'From MGMT to CONTAINERS'
set firewall ipv4 name mgmt-containers rule 40 action 'accept'
set firewall ipv4 name mgmt-containers rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name mgmt-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name mgmt-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name mgmt-containers rule 999 action 'drop'
set firewall ipv4 name mgmt-containers rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name mgmt-containers rule 999 state invalid 'enable'
set firewall ipv4 name mgmt-containers rule 999 log 'enable'

# From MGMT to WAN
set firewall ipv4 name mgmt-wan default-action 'accept'
set firewall ipv4 name mgmt-wan description 'From MGMT to WAN'

############################################################################################################ 
# INFRA
############################################################################################################
# From INFRA to VYOS
set firewall ipv4 name infra-local default-action 'drop'
set firewall ipv4 name infra-local description 'From INFRA to VYOS'
set firewall ipv4 name infra-local enable-default-log
set firewall ipv4 name infra-local rule 50 action 'accept'
set firewall ipv4 name infra-local rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name infra-local rule 50 destination port '67,68'
set firewall ipv4 name infra-local rule 50 protocol 'udp'
set firewall ipv4 name infra-local rule 50 source port '67,68'
set firewall ipv4 name infra-local rule 60 action 'accept'
set firewall ipv4 name infra-local rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name infra-local rule 60 destination port 'ntp'
set firewall ipv4 name infra-local rule 60 protocol 'udp'
set firewall ipv4 name infra-local rule 70 action 'accept'
set firewall ipv4 name infra-local rule 70 description 'Rule: Accept_BGP'
set firewall ipv4 name infra-local rule 70 destination port 'bgp'
set firewall ipv4 name infra-local rule 70 protocol 'tcp'
set firewall ipv4 name infra-local rule 80 action 'accept'
set firewall ipv4 name infra-local rule 80 description 'Rule: Accept_TFTP'
set firewall ipv4 name infra-local rule 80 destination port '69'
set firewall ipv4 name infra-local rule 80 protocol 'udp'
set firewall ipv4 name infra-local rule 100 action 'accept'
set firewall ipv4 name infra-local rule 100 description 'Rule: Accept_node_exporter_from_k8s_nodes'
set firewall ipv4 name infra-local rule 100 destination port '9100'
set firewall ipv4 name infra-local rule 100 protocol 'tcp'
set firewall ipv4 name infra-local rule 100 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name infra-local rule 110 action 'accept'
set firewall ipv4 name infra-local rule 110 description 'Rule: Accept_speedtest_exporter_from_k8s_nodes'
set firewall ipv4 name infra-local rule 110 destination port '9798'
set firewall ipv4 name infra-local rule 110 protocol 'tcp'
set firewall ipv4 name infra-local rule 110 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name infra-local rule 999 action 'drop'
set firewall ipv4 name infra-local rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name infra-local rule 999 state invalid 'enable'
set firewall ipv4 name infra-local rule 999 log 'enable'

# From INFRA to MGMT
set firewall ipv4 name infra-mgmt default-action 'drop'
set firewall ipv4 name infra-mgmt description 'From INFRA to MGMT'
set firewall ipv4 name infra-mgmt enable-default-log
set firewall ipv4 name infra-mgmt rule 999 action 'drop'
set firewall ipv4 name infra-mgmt rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name infra-mgmt rule 999 state invalid 'enable'
set firewall ipv4 name infra-mgmt rule 999 log 'enable'

# From INFRA to HOME
set firewall ipv4 name infra-home default-action 'drop'
set firewall ipv4 name infra-home description 'From INFRA to HOME'
set firewall ipv4 name infra-home enable-default-log
set firewall ipv4 name infra-home rule 999 action 'drop'
set firewall ipv4 name infra-home rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name infra-home rule 999 state invalid 'enable'
set firewall ipv4 name infra-home rule 999 log 'enable'

# From INFRA to IOT
set firewall ipv4 name infra-iot default-action 'drop'
set firewall ipv4 name infra-iot description 'From INFRA to IOT'
set firewall ipv4 name infra-iot enable-default-log
set firewall ipv4 name infra-iot rule 100 action 'accept'
set firewall ipv4 name infra-iot rule 100 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name infra-iot rule 100 protocol 'tcp'
set firewall ipv4 name infra-iot rule 100 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name infra-iot rule 110 action 'accept'
set firewall ipv4 name infra-iot rule 110 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name infra-iot rule 110 protocol 'icmp'
set firewall ipv4 name infra-iot rule 110 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name infra-iot rule 999 action 'drop'
set firewall ipv4 name infra-iot rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name infra-iot rule 999 state invalid 'enable'
set firewall ipv4 name infra-iot rule 999 log 'enable'

# From INFRA to CCTV
set firewall ipv4 name infra-cctv default-action 'drop'
set firewall ipv4 name infra-cctv description 'From INFRA to CCTV'
set firewall ipv4 name infra-cctv enable-default-log
set firewall ipv4 name infra-cctv rule 100 action 'accept'
set firewall ipv4 name infra-cctv rule 100 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name infra-cctv rule 100 protocol 'tcp_udp'
set firewall ipv4 name infra-cctv rule 100 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name infra-cctv rule 999 action 'drop'
set firewall ipv4 name infra-cctv rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name infra-cctv rule 999 state invalid 'enable'
set firewall ipv4 name infra-cctv rule 999 log 'enable'

# From INFRA to CONTAINERS
set firewall ipv4 name infra-containers default-action 'accept'
set firewall ipv4 name infra-containers description 'From INFRA to CONTAINERS'
set firewall ipv4 name infra-containers enable-default-log
set firewall ipv4 name infra-containers rule 40 action 'accept'
set firewall ipv4 name infra-containers rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name infra-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name infra-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name infra-containers rule 100 action 'accept'
set firewall ipv4 name infra-containers rule 100 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name infra-containers rule 100 protocol 'tcp'
set firewall ipv4 name infra-containers rule 100 source group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name infra-containers rule 999 action 'drop'
set firewall ipv4 name infra-containers rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name infra-containers rule 999 state invalid 'enable'
set firewall ipv4 name infra-containers rule 999 log 'enable'

# From INFRA to WAN
set firewall ipv4 name infra-wan default-action 'accept'
set firewall ipv4 name infra-wan description 'From INFRA to WAN'

############################################################################################################ 
# HOME
############################################################################################################
# From HOME to VYOS
set firewall ipv4 name home-local default-action 'drop'
set firewall ipv4 name home-local description 'From HOME to VYOS'
set firewall ipv4 name home-local enable-default-log
set firewall ipv4 name home-local rule 50 action 'accept'
set firewall ipv4 name home-local rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name home-local rule 50 destination port '67,68'
set firewall ipv4 name home-local rule 50 protocol 'udp'
set firewall ipv4 name home-local rule 50 source port '67,68'
set firewall ipv4 name home-local rule 60 action 'accept'
set firewall ipv4 name home-local rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name home-local rule 60 destination port 'ntp'
set firewall ipv4 name home-local rule 60 protocol 'udp'
set firewall ipv4 name home-local rule 999 action 'drop'
set firewall ipv4 name home-local rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name home-local rule 999 state invalid 'enable'
set firewall ipv4 name home-local rule 999 log 'enable'

# From HOME to MGMT
set firewall ipv4 name home-mgmt default-action 'drop'
set firewall ipv4 name home-mgmt description 'From HOME to MGMT'
set firewall ipv4 name home-mgmt enable-default-log
set firewall ipv4 name home-mgmt rule 999 action 'drop'
set firewall ipv4 name home-mgmt rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name home-mgmt rule 999 state invalid 'enable'
set firewall ipv4 name home-mgmt rule 999 log 'enable'

# From HOME to INFRA
set firewall ipv4 name home-infra default-action 'drop'
set firewall ipv4 name home-infra description 'From HOME to INFRA'
set firewall ipv4 name home-infra enable-default-log
set firewall ipv4 name home-infra rule 999 action 'drop'
set firewall ipv4 name home-infra rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name home-infra rule 999 state invalid 'enable'
set firewall ipv4 name home-infra rule 999 log 'enable'

# From HOME to IOT
set firewall ipv4 name home-iot default-action 'drop'
set firewall ipv4 name home-iot description 'From HOME to IOT'
set firewall ipv4 name home-iot enable-default-log
set firewall ipv4 name home-iot rule 999 action 'drop'
set firewall ipv4 name home-iot rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name home-iot rule 999 state invalid 'enable'
set firewall ipv4 name home-iot rule 999 log 'enable'

# From HOME to CCTV
set firewall ipv4 name home-video default-action 'drop'
set firewall ipv4 name home-video description 'From HOME to CCTV'
set firewall ipv4 name home-video enable-default-log
set firewall ipv4 name home-video rule 999 action 'drop'
set firewall ipv4 name home-video rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name home-video rule 999 state invalid 'enable'
set firewall ipv4 name home-video rule 999 log 'enable'

# From HOME to CONTAINERS
set firewall ipv4 name home-containers default-action 'accept'
set firewall ipv4 name home-containers description 'From HOME to CONTAINERS'
set firewall ipv4 name home-containers rule 40 action 'accept'
set firewall ipv4 name home-containers rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name home-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name home-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name home-containers rule 999 action 'drop'
set firewall ipv4 name home-containers rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name home-containers rule 999 state invalid 'enable'
set firewall ipv4 name home-containers rule 999 log 'enable'

# From HOME to WAN
set firewall ipv4 name home-wan default-action 'accept'
set firewall ipv4 name home-wan description 'From HOME to WAN'

############################################################################################################ 
# IOT
############################################################################################################
# From IOT to VYOS
set firewall ipv4 name iot-local default-action 'drop'
set firewall ipv4 name iot-local description 'From IOT to VYOS'
set firewall ipv4 name iot-local enable-default-log
set firewall ipv4 name iot-local rule 50 action 'accept'
set firewall ipv4 name iot-local rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name iot-local rule 50 destination port '67,68'
set firewall ipv4 name iot-local rule 50 protocol 'udp'
set firewall ipv4 name iot-local rule 50 source port '67,68'
set firewall ipv4 name iot-local rule 60 action 'accept'
set firewall ipv4 name iot-local rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name iot-local rule 60 destination port 'ntp'
set firewall ipv4 name iot-local rule 60 protocol 'udp'
set firewall ipv4 name iot-local rule 100 action 'accept'
set firewall ipv4 name iot-local rule 100 description 'Rule: Accept_IGMP'
set firewall ipv4 name iot-local rule 100 protocol '2'
set firewall ipv4 name iot-local rule 110 action 'accept'
set firewall ipv4 name iot-local rule 110 description 'Rule: Accept_MDNS'
set firewall ipv4 name iot-local rule 110 destination port 'mdns'
set firewall ipv4 name iot-local rule 110 protocol 'udp'
set firewall ipv4 name iot-local rule 110 source port 'mdns'
set firewall ipv4 name iot-local rule 999 action 'drop'
set firewall ipv4 name iot-local rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name iot-local rule 999 state invalid 'enable'
set firewall ipv4 name iot-local rule 999 log 'enable'

# From IOT to MGMT
set firewall ipv4 name iot-mgmt default-action 'drop'
set firewall ipv4 name iot-mgmt description 'From IOT to MGMT'
set firewall ipv4 name iot-mgmt enable-default-log
set firewall ipv4 name iot-mgmt rule 999 action 'drop'
set firewall ipv4 name iot-mgmt rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name iot-mgmt rule 999 state invalid 'enable'
set firewall ipv4 name iot-mgmt rule 999 log 'enable'

# From IOT to INFRA
set firewall ipv4 name iot-infra default-action 'drop'
set firewall ipv4 name iot-infra description 'From IOT to infra'
set firewall ipv4 name iot-infra enable-default-log
set firewall ipv4 name iot-infra rule 100 action 'accept'
set firewall ipv4 name iot-infra rule 100 description 'Rule: Accept_nas_smb_from_scanners'
set firewall ipv4 name iot-infra rule 100 destination group address-group 'FW_AG_NAS_ADDR'
set firewall ipv4 name iot-infra rule 100 destination port 'microsoft-ds'
set firewall ipv4 name iot-infra rule 100 protocol 'tcp'
set firewall ipv4 name iot-infra rule 100 source group address-group 'scanners'
set firewall ipv4 name iot-infra rule 200 action 'accept'
set firewall ipv4 name iot-infra rule 200 description 'Rule: Accept_plex_from_plex_clients'
set firewall ipv4 name iot-infra rule 200 destination group address-group 'FW_AG_K8S_PLEX_SVC'
set firewall ipv4 name iot-infra rule 200 destination port '32400'
set firewall ipv4 name iot-infra rule 200 protocol 'tcp'
set firewall ipv4 name iot-infra rule 200 source group address-group 'FW_AG_PLEX_CLIENTS_IOT'
set firewall ipv4 name iot-infra rule 300 action 'accept'
set firewall ipv4 name iot-infra rule 300 description 'Rule: Accept_mqtt_from_mqtt_clients'
set firewall ipv4 name iot-infra rule 300 destination group address-group 'FW_AG_K8S_MQTT_SVC'
set firewall ipv4 name iot-infra rule 300 destination port '1883'
set firewall ipv4 name iot-infra rule 300 protocol 'tcp'
set firewall ipv4 name iot-infra rule 300 source group address-group 'FW_AG_MQTT_CLIENTS_IOT'
set firewall ipv4 name iot-infra rule 410 action 'accept'
set firewall ipv4 name iot-infra rule 410 description 'Rule: Accept_k8s_ingress_from_allowed_devices'
set firewall ipv4 name iot-infra rule 410 destination group address-group 'FW_AG_K8S_INGRESS_SVC'
set firewall ipv4 name iot-infra rule 410 destination port 'http,https'
set firewall ipv4 name iot-infra rule 410 protocol 'tcp'
set firewall ipv4 name iot-infra rule 410 source group network-group 'FW_NG_IOT'
set firewall ipv4 name iot-infra rule 999 action 'drop'
set firewall ipv4 name iot-infra rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name iot-infra rule 999 state invalid 'enable'
set firewall ipv4 name iot-infra rule 999 log 'enable'

# From IOT to HOME
set firewall ipv4 name iot-home default-action 'drop'
set firewall ipv4 name iot-home description 'From IOT to HOME'
set firewall ipv4 name iot-home enable-default-log
set firewall ipv4 name iot-home rule 999 action 'drop'
set firewall ipv4 name iot-home rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name iot-home rule 999 state invalid 'enable'
set firewall ipv4 name iot-home rule 999 log 'enable'

# From IOT to CCTV
set firewall ipv4 name iot-cctv default-action 'drop'
set firewall ipv4 name iot-cctv description 'From IOT to CCTV'
set firewall ipv4 name iot-cctv enable-default-log
set firewall ipv4 name iot-cctv rule 100 action 'accept'
set firewall ipv4 name iot-cctv rule 100 description 'Rule: Accept_k8s_iot_nodes_tcp'
set firewall ipv4 name iot-cctv rule 100 protocol 'tcp'
set firewall ipv4 name iot-cctv rule 100 source group address-group 'FW_AG_K8S_WORKER_IOT_ADDR'
set firewall ipv4 name iot-cctv rule 101 action 'accept'
set firewall ipv4 name iot-cctv rule 101 description 'Rule: Accept_k8s_iot_nodes_udp'
set firewall ipv4 name iot-cctv rule 101 protocol 'udp'
set firewall ipv4 name iot-cctv rule 101 source group address-group 'FW_AG_K8S_WORKER_IOT_ADDR'
set firewall ipv4 name iot-cctv rule 999 action 'drop'
set firewall ipv4 name iot-cctv rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name iot-cctv rule 999 state invalid 'enable'
set firewall ipv4 name iot-cctv rule 999 log 'enable'

# From IOT to CONTAINERS
set firewall ipv4 name iot-containers default-action 'accept'
set firewall ipv4 name iot-containers description 'From IOT to CONTAINERS'
set firewall ipv4 name iot-containers rule 40 action 'accept'
set firewall ipv4 name iot-containers rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name iot-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name iot-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name iot-containers rule 999 action 'drop'
set firewall ipv4 name iot-containers rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name iot-containers rule 999 state invalid 'enable'
set firewall ipv4 name iot-containers rule 999 log 'enable'

# From IOT to WAN
set firewall ipv4 name iot-wan default-action 'accept'
set firewall ipv4 name iot-wan description 'From IOT to WAN'

############################################################################################################ 
# CONTAINERS
############################################################################################################
# From CONTAINERS to VYOS
set firewall ipv4 name containers-local default-action 'drop'
set firewall ipv4 name containers-local description 'From CONTAINERS to VYOS'
set firewall ipv4 name containers-local enable-default-log
set firewall ipv4 name containers-local rule 50 action 'accept'
set firewall ipv4 name containers-local rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name containers-local rule 50 destination port '67,68'
set firewall ipv4 name containers-local rule 50 protocol 'udp'
set firewall ipv4 name containers-local rule 50 source port '67,68'
set firewall ipv4 name containers-local rule 60 action 'accept'
set firewall ipv4 name containers-local rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name containers-local rule 60 destination port 'ntp'
set firewall ipv4 name containers-local rule 60 protocol 'udp'
set firewall ipv4 name containers-local rule 999 action 'drop'
set firewall ipv4 name containers-local rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name containers-local rule 999 state invalid 'enable'
set firewall ipv4 name containers-local rule 999 log 'enable'

# From CONTAINERS to MGMT
set firewall ipv4 name containers-mgmt default-action 'drop'
set firewall ipv4 name containers-mgmt description 'From CONTAINERS to MGMT'
set firewall ipv4 name containers-mgmt enable-default-log
set firewall ipv4 name containers-mgmt rule 999 action 'drop'
set firewall ipv4 name containers-mgmt rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name containers-mgmt rule 999 state invalid 'enable'
set firewall ipv4 name containers-mgmt rule 999 log 'enable'

# From CONTAINERS to INFRA
set firewall ipv4 name containers-infra default-action 'accept'
set firewall ipv4 name containers-infra description 'From CONTAINERS to INFRA'
set firewall ipv4 name containers-infra rule 999 action 'drop'
set firewall ipv4 name containers-infra rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name containers-infra rule 999 state invalid 'enable'
set firewall ipv4 name containers-infra rule 999 log 'enable'

# From CONTAINERS to HOME
set firewall ipv4 name containers-home default-action 'drop'
set firewall ipv4 name containers-home description 'From CONTAINERS to HOME'
set firewall ipv4 name containers-home enable-default-log
set firewall ipv4 name containers-home rule 999 action 'drop'
set firewall ipv4 name containers-home rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name containers-home rule 999 state invalid 'enable'
set firewall ipv4 name containers-home rule 999 log 'enable'

# From CONTAINERS to IOT
set firewall ipv4 name containers-iot default-action 'drop'
set firewall ipv4 name containers-iot description 'From CONTAINERS to IOT'
set firewall ipv4 name containers-iot enable-default-log
set firewall ipv4 name containers-iot rule 999 action 'drop'
set firewall ipv4 name containers-iot rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name containers-iot rule 999 state invalid 'enable'
set firewall ipv4 name containers-iot rule 999 log 'enable'

# From CONTAINERS to CCTV
set firewall ipv4 name containers-cctv default-action 'drop'
set firewall ipv4 name containers-cctv description 'From CONTAINERS to CCTV'
set firewall ipv4 name containers-cctv enable-default-log
set firewall ipv4 name containers-cctv rule 999 action 'drop'
set firewall ipv4 name containers-cctv rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name containers-cctv rule 999 state invalid 'enable'
set firewall ipv4 name containers-cctv rule 999 log 'enable'

# From CONTAINERS to WAN
set firewall ipv4 name containers-wan default-action 'accept'
set firewall ipv4 name containers-wan description 'From CONTAINERS to WAN'

############################################################################################################ 
# CCTV
############################################################################################################
# From CCTV to VYOS
set firewall ipv4 name cctv-local default-action 'drop'
set firewall ipv4 name cctv-local description 'From CCTV to VYOS'
set firewall ipv4 name cctv-local enable-default-log
set firewall ipv4 name cctv-local rule 50 action 'accept'
set firewall ipv4 name cctv-local rule 50 description 'Rule: Accept_DHCP'
set firewall ipv4 name cctv-local rule 50 destination port '67,68'
set firewall ipv4 name cctv-local rule 50 protocol 'udp'
set firewall ipv4 name cctv-local rule 50 source port '67,68'
set firewall ipv4 name cctv-local rule 60 action 'accept'
set firewall ipv4 name cctv-local rule 60 description 'Rule: Accept_NTP'
set firewall ipv4 name cctv-local rule 60 destination port 'ntp'
set firewall ipv4 name cctv-local rule 60 protocol 'udp'
set firewall ipv4 name cctv-local rule 999 action 'drop'
set firewall ipv4 name cctv-local rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name cctv-local rule 999 state invalid 'enable'
set firewall ipv4 name cctv-local rule 999 log 'enable'

# From CCTV to MGMT
set firewall ipv4 name cctv-mgmt default-action 'drop'
set firewall ipv4 name cctv-mgmt description 'From CCTV to MGMT'
set firewall ipv4 name cctv-mgmt enable-default-log
set firewall ipv4 name cctv-mgmt rule 999 action 'drop'
set firewall ipv4 name cctv-mgmt rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name cctv-mgmt rule 999 state invalid 'enable'
set firewall ipv4 name cctv-mgmt rule 999 log 'enable'

# From CCTV to INFRA
set firewall ipv4 name cctv-infra default-action 'drop'
set firewall ipv4 name cctv-infra description 'From CCTV to INFRA'
set firewall ipv4 name cctv-infra enable-default-log
set firewall ipv4 name cctv-infra rule 100 action 'accept'
set firewall ipv4 name cctv-infra rule 100 description 'Rule: Accept_k8s_nodes'
set firewall ipv4 name cctv-infra rule 100 protocol 'udp'
set firewall ipv4 name cctv-infra rule 100 destination group address-group 'FW_AG_K8S_WORKER_INFRA_ADDR'
set firewall ipv4 name cctv-infra rule 100 source port '6987-6989'
set firewall ipv4 name cctv-infra rule 999 action 'drop'
set firewall ipv4 name cctv-infra rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name cctv-infra rule 999 state invalid 'enable'
set firewall ipv4 name cctv-infra rule 999 log 'enable'

# From CCTV to HOME
set firewall ipv4 name cctv-home default-action 'drop'
set firewall ipv4 name cctv-home description 'From CCTV to HOME'
set firewall ipv4 name cctv-home enable-default-log
set firewall ipv4 name cctv-home rule 999 action 'drop'
set firewall ipv4 name cctv-home rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name cctv-home rule 999 state invalid 'enable'
set firewall ipv4 name cctv-home rule 999 log 'enable'

# From CCTV to IOT
set firewall ipv4 name cctv-iot default-action 'drop'
set firewall ipv4 name cctv-iot description 'From CCTV to IOT'
set firewall ipv4 name cctv-iot enable-default-log
set firewall ipv4 name cctv-iot rule 100 action 'accept'
set firewall ipv4 name cctv-iot rule 100 description 'Rule: allow connecting to hass'
set firewall ipv4 name cctv-iot rule 100 protocol 'tcp'
set firewall ipv4 name cctv-iot rule 100 destination group address-group 'FW_AG_K8S_HASS_SVC'
set firewall ipv4 name cctv-iot rule 100 destination port '8123'
set firewall ipv4 name cctv-iot rule 999 action 'drop'
set firewall ipv4 name cctv-iot rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name cctv-iot rule 999 state invalid 'enable'
set firewall ipv4 name cctv-iot rule 999 log 'enable'

# From CCTV to CONTAINERS
set firewall ipv4 name cctv-containers default-action 'accept'
set firewall ipv4 name cctv-containers description 'From CCTV to CONTAINERS'
set firewall ipv4 name cctv-containers rule 40 action 'accept'
set firewall ipv4 name cctv-containers rule 40 description 'Rule: Accept_DNS'
set firewall ipv4 name cctv-containers rule 40 destination port 'domain,domain-s'
set firewall ipv4 name cctv-containers rule 40 protocol 'tcp_udp'
set firewall ipv4 name cctv-containers rule 999 action 'drop'
set firewall ipv4 name cctv-containers rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name cctv-containers rule 999 state invalid 'enable'
set firewall ipv4 name cctv-containers rule 999 log 'enable'

# From CCTV to WAN
set firewall ipv4 name cctv-wan default-action 'drop'
set firewall ipv4 name cctv-wan description 'From CCTV to WAN'


############################################################################################################ 
# CCTV
############################################################################################################
# From WAN to VYOS
set firewall ipv4 name wan-local default-action 'drop'
set firewall ipv4 name wan-local description 'From WAN to VYOS'
set firewall ipv4 name wan-local enable-default-log
set firewall ipv4 name wan-local rule 1 action 'drop'
set firewall ipv4 name wan-local rule 1 description 'Rule: Drop_Invalid'
set firewall ipv4 name wan-local rule 1 state invalid 'enable'
set firewall ipv4 name wan-local rule 1 log 'enable'
set firewall ipv4 name wan-local rule 100 action 'accept'
set firewall ipv4 name wan-local rule 100 description 'Rule: Accept_wireguard'
set firewall ipv4 name wan-local rule 100 destination port '51820'
set firewall ipv4 name wan-local rule 100 protocol 'udp'

# From WAN to MGMT
set firewall ipv4 name wan-mgmt default-action 'drop'
set firewall ipv4 name wan-mgmt description 'From WAN to MGMT'
set firewall ipv4 name wan-mgmt enable-default-log
set firewall ipv4 name wan-mgmt rule 999 action 'drop'
set firewall ipv4 name wan-mgmt rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name wan-mgmt rule 999 state invalid 'enable'
set firewall ipv4 name wan-mgmt rule 999 log 'enable'

# From WAN to INFRA
set firewall ipv4 name wan-infra default-action 'drop'
set firewall ipv4 name wan-infra description 'From WAN to INFRA'
set firewall ipv4 name wan-infra enable-default-log
set firewall ipv4 name wan-infra rule 999 action 'drop'
set firewall ipv4 name wan-infra rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name wan-infra rule 999 state invalid 'enable'
set firewall ipv4 name wan-infra rule 999 log 'enable'

# From WAN to HOME
set firewall ipv4 name wan-home default-action 'drop'
set firewall ipv4 name wan-home description 'From WAN to HOME'
set firewall ipv4 name wan-home enable-default-log
set firewall ipv4 name wan-home rule 999 action 'drop'
set firewall ipv4 name wan-home rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name wan-home rule 999 state invalid 'enable'
set firewall ipv4 name wan-home rule 999 log 'enable'

# From WAN to IOT
set firewall ipv4 name wan-iot default-action 'drop'
set firewall ipv4 name wan-iot description 'From WAN to IOT'
set firewall ipv4 name wan-iot enable-default-log
set firewall ipv4 name wan-iot rule 999 action 'drop'
set firewall ipv4 name wan-iot rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name wan-iot rule 999 state invalid 'enable'
set firewall ipv4 name wan-iot rule 999 log 'enable'

# From WAN to CCTV
set firewall ipv4 name wan-cctv default-action 'drop'
set firewall ipv4 name wan-cctv description 'From WAN to CCTV'
set firewall ipv4 name wan-cctv enable-default-log
set firewall ipv4 name wan-cctv rule 999 action 'drop'
set firewall ipv4 name wan-cctv rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name wan-cctv rule 999 state invalid 'enable'
set firewall ipv4 name wan-cctv rule 999 log 'enable'

# From WAN to CONTAINERS
set firewall ipv4 name wan-containers default-action 'drop'
set firewall ipv4 name wan-containers description 'From WAN to CONTAINERS'
set firewall ipv4 name wan-containers enable-default-log
set firewall ipv4 name wan-containers rule 999 action 'drop'
set firewall ipv4 name wan-containers rule 999 description 'Rule: Drop_Invalid'
set firewall ipv4 name wan-containers rule 999 state invalid 'enable'
set firewall ipv4 name wan-containers rule 999 log 'enable'
