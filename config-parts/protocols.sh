#!/bin/vbash
# shellcheck disable=all


set protocols bgp neighbor 172.16.11.13 address-family ipv4-unicast
set protocols bgp neighbor 172.16.11.13 description 'k8s-w0'
set protocols bgp neighbor 172.16.11.13 remote-as '64512'
set protocols bgp neighbor 172.16.11.14 address-family ipv4-unicast
set protocols bgp neighbor 172.16.11.14 description 'k8s-w1'
set protocols bgp neighbor 172.16.11.14 remote-as '64512'
set protocols bgp neighbor 172.16.11.15 address-family ipv4-unicast
set protocols bgp neighbor 172.16.11.15 description 'k8s-w2'
set protocols bgp neighbor 172.16.11.15 remote-as '64512'
set protocols bgp neighbor 172.16.11.16 address-family ipv4-unicast
set protocols bgp neighbor 172.16.11.16 description 'k8s-w3'
set protocols bgp neighbor 172.16.11.16 remote-as '64512'
set protocols bgp parameters router-id '172.16.10.254'
set protocols bgp system-as '64512'

