#!/bin/bash

iptables -F
iptables -X
iptables -Z
iptables -t nat -F

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A FORWARD -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.56.0/24 -o enp0s8 -j MASQUERADE
echo "1" > /proc/sys/net/ipv4/ip_forward

#INTERCEPT

acl https port 443
http_access allow https
http_port 3128 intercept

#NORMAL

acl lan src 192.168.56.0/24
http_access allow lan