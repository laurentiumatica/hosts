#!/bin/bash

check_ip() {
    local hostname="$1"
    local ip_din_hosts="$2"
    local dns_server="$3"

    ip_rezolvat=$(host -t A "$hostname" "$dns_server" 2>/dev/null | grep 'has address' | awk '{print $NF}' | head -n 1)

    if [[ -n "$ip_rezolvat" && "$ip_din_hosts" != "$ip_rezolvat" ]]; then
        echo "Bogus IP for $hostname in /etc/hosts!"
    fi
}

cat /etc/hosts | while read ip hostname garbage;
do
    if [[ -n "$ip" && "$ip" =~ ^[0-9] && -n "$hostname" ]]; then
        check_ip "$hostname" "$ip" "$DEFAULT_DNS"
    fi
done
echo "Salut Laurentiu!"
