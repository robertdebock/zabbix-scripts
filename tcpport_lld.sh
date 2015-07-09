#!/bin/bash

# A script to report all open ports on a host. Requires the package "nmap" to be installed.

# Zabbix needs to be configured in order to use this script:
# Discovery:
# Name: Open TCP ports
# Type: External check
# Key: zabbix_tcpport_lld.sh[{HOST.CONN}]
# (This makes the variable {#PORT} and {#PROTO} available for use in the items and triggers.)

# Item Prototypes
# Name: Status of port {#PORT}/{#PROTO}
# Type: Simple check
# Key: net.tcp.service[{#PROTO},,{#PORT}]
# Type of information: Numeric (unsigned)
# Data type: Boolean

# Trigger Prototypes
# Name: {#PROTO} port {#PORT}
# Expression: {Template_network:net.tcp.service[{#PROTO},,{#PORT}].last(0)}=0

echo '{'
echo ' "data":['

nmap -T4 -F ${1} | grep 'open' | while read portproto state protocol ; do
  port=$(echo ${portproto} | cut -d/ -f1)
  proto=$(echo ${portproto} | cut -d/ -f2)
  echo '  { "{#PORT}":"'${port}'", "{#PROTO}":"'${proto}'" },'
done

echo ' ]'
echo '}'
