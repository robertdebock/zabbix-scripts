#!/bin/sh

echo '{'
echo ' "data":['

nmap -T4 -F ${1} | grep 'open' | while read portproto state protocol ; do
  port=$(echo ${portproto} | cut -d/ -f1)
  proto=$(echo ${portproto} | cut -d/ -f2)
  echo '  { "{#PORT}":"'${port}'", "{#PROTO}":"'${proto}'" },'
done

echo ' ]'
echo '}'
