#!/bin/vbash

# Interface groups
set firewall group interface-group FW_IG_MGMT interface 'bond0'
set firewall group interface-group FW_IG_INFRA interface 'bond0.1611'
set firewall group interface-group FW_IG_HOME interface 'bond0.1612'
set firewall group interface-group FW_IG_IOT interface 'bond0.1613'
set firewall group interface-group FW_IG_CCTV interface 'bond0.1614'
set firewall group interface-group FW_IG_WAN interface 'pppoe0'
set firewall group interface-group FW_IG_CONTAINERS interface 'pod-containers'
# set firewall group interface-group FW_IG_WIREGUARD interface 'wg01'

# Router (VyOS itself)
set firewall group address-group FW_AG_ROUTER_ADDR_IPV4 address 10.0.0.1
set firewall group address-group FW_AG_ROUTER_ADDR_IPV4 address 127.0.0.1
set firewall group ipv6-address-group FW_AG_ROUTER_ADDR_IPV6 address fe80::e63a:6eff:fe5a:f805
set firewall group ipv6-address-group FW_AG_ROUTER_ADDR_IPV6 address ::1

# k8s nodes
set firewall group address-group FW_AG_K8S_WORKER_INFRA_ADDR address '172.16.11.13-172.16.11.16' # Servers vLAN
set firewall group address-group FW_AG_K8S_WORKER_IOT_ADDR address '172.16.13.13-172.16.13.16' # IoT vLAN

# Storage devices
set firewall group address-group FW_AG_NAS_ADDR address '172.16.11.1'
set firewall group address-group FW_AG_NAS_ADDR address '172.16.11.3'

# k8s ingress client devices
set firewall group address-group k8s_ingress_allowed address '10.1.3.35'
set firewall group address-group k8s_ingress_allowed address '10.1.3.36'
set firewall group address-group k8s_ingress_allowed address '10.1.3.53'
set firewall group address-group k8s_ingress_allowed address '10.1.3.54'

# k8s cluster services
set firewall group address-group k8s_api address '10.5.0.2'
set firewall group address-group k8s_hass address '10.1.3.151'
set firewall group address-group k8s_ingress address '10.45.0.1'
set firewall group address-group k8s_ingress address '10.45.0.3'
set firewall group address-group k8s_mqtt address '10.45.0.10'
set firewall group address-group k8s_plex address '10.45.0.20'
set firewall group address-group k8s_vector_aggregator address '10.45.0.2'

# MQTT client devices
set firewall group address-group mqtt_clients address '10.1.2.21' # Bernd
set firewall group address-group mqtt_clients address '10.1.2.32'
set firewall group address-group mqtt_clients address '10.1.3.18' # Vacuum livingroom
set firewall group address-group mqtt_clients address '10.1.3.22' # Vacuum upstairs
set firewall group address-group mqtt_clients address '10.1.3.38' # Ventilation ESP

# Plex client devices
set firewall group address-group plex_clients address '10.1.2.21' # Bernd
set firewall group address-group plex_clients address '10.1.2.31-10.1.2.32'
set firewall group address-group plex_clients address '10.1.2.22' # Man-Yie
set firewall group address-group plex_clients address '10.1.2.33-10.1.2.34'
set firewall group address-group plex_clients address '10.1.2.35' # Eva
set firewall group address-group plex_clients address '10.1.2.36' # Kitchen
set firewall group address-group plex_clients address '10.1.3.16' # Apple TV

# Printers
set firewall group address-group printers address '10.1.3.55'

# 3D printer
set firewall group port-group bambu-discovery port '1990'
set firewall group port-group bambu-discovery port '2021'

set firewall group address-group bambu-printers address '10.1.3.11'

# Printer client machines
set firewall group address-group printer_allowed address '192.168.2.11'

# Unifi devices
set firewall group address-group unifi_devices address '10.1.0.11-10.1.0.13' # Switches
set firewall group address-group unifi_devices address '10.1.0.21-10.1.0.24' # AP's

# Vyos containers addresses
set firewall group address-group vyos_coredns address '10.5.0.3'
set firewall group address-group vyos_dnsdist address '10.5.0.4'
set firewall group address-group vyos_unifi address '10.5.0.10'

# Port groups
set firewall group port-group wireguard port '51820'
