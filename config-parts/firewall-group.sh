#!/bin/vbash

# Interface groups
set firewall group interface-group ZONE_WAN interface 'pppoe0'
set firewall group interface-group ZONE_MGMT interface 'bond0'
set firewall group interface-group ZONE_INFRA interface 'bond0.1611'
set firewall group interface-group ZONE_HOME interface 'bond0.1612'
set firewall group interface-group ZONE_IOT interface 'bond0.1613' 
set firewall group interface-group ZONE_CCTV interface 'bond0.1614'
set firewall group interface-group ZONE_CONTAINERS interface 'pod-containers'
# set firewall group interface-group ZONE_WIREGUARD interface 'wg01'
# Network Group
set firewall group network-group FW_NG_MGMT network '172.16.10.0/24'
set firewall group network-group FW_NG_INFRA network '172.16.11.0/24'
set firewall group network-group FW_NG_HOME network '172.16.12.0/24'
set firewall group network-group FW_NG_IOT network '172.16.13.0/24'
set firewall group network-group FW_NG_CCTV network '172.16.14.0/24'
set firewall group network-group FW_NG_CONTAINERS network '172.16.16.0/24'
set firewall group network-group FW_NG_SERVICES network '10.11.10.0/24'
# Router (VyOS itself)
set firewall group address-group FW_AG_ROUTER_ADDR_IPV4 address '10.0.0.1'
set firewall group address-group FW_AG_ROUTER_ADDR_IPV4 address '127.0.0.1'
set firewall group ipv6-address-group FW_AG_ROUTER_ADDR_IPV6 address 'fe80::e63a:6eff:fe5a:f805'
set firewall group ipv6-address-group FW_AG_ROUTER_ADDR_IPV6 address '::1'
# Printer Scanner
set firewall group address-group FW_AG_PRINTER_ADDR address '172.16.12.100'
# k8s nodes
set firewall group address-group FW_AG_K8S_INFRA_NODES address '172.16.11.10-172.16.11.16'
set firewall group address-group FW_AG_K8S_IOT_NODES address '172.16.13.13-172.16.13.16'
# Storage devices
set firewall group address-group FW_AG_NAS_ADDR address '172.16.11.1'
set firewall group address-group FW_AG_NAS_ADDR address '172.16.11.3'
# k8s cluster services
set firewall group address-group FW_AG_K8S_API_SVC address '172.16.16.4'
set firewall group address-group FW_AG_K8S_HASS_SVC address '172.16.13.1'
set firewall group address-group FW_AG_K8S_INGRESS_SVC address '10.11.10.1'
set firewall group address-group FW_AG_K8S_VECTOR_SVC address '10.11.10.2'
set firewall group address-group FW_AG_K8S_PLEX_SVC address '10.11.10.3'
set firewall group address-group FW_AG_K8S_MQTT_SVC address '10.11.10.4'
# MQTT client devices
set firewall group address-group FW_AG_MQTT_CLIENTS_IOT address '172.16.13.100' # Shelly EM3
set firewall group address-group FW_AG_MQTT_CLIENTS_HOME address '172.16.12.102' # 
set firewall group address-group FW_AG_MQTT_CLIENTS_HOME address '172.16.12.105' #
# PLEX client devices
set firewall group address-group FW_AG_PLEX_CLIENTS_IOT address '172.16.13.100'
set firewall group address-group FW_AG_PLEX_CLIENTS_IOT address '172.16.13.101'
set firewall group address-group FW_AG_PLEX_CLIENTS_HOME address '172.16.12.100'
# Vyos containers addresses
set firewall group address-group FW_AG_VYOS_OMADA address '172.16.16.6'
set firewall group address-group FW_AG_VYOS_DNS address '172.16.16.2'
set firewall group address-group FW_AG_VYOS_DNS address '172.16.16.3'
set firewall group address-group FW_AG_VYOS_DNS address '172.16.16.5'
set firewall group address-group FW_AG_VYOS_COREDNS address '172.16.16.7'
# Port groups
set firewall group port-group FW_PG_WIREGUARD port '51820'