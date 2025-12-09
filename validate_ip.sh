#!/bin/bash

cat /etc/hosts | while read ip hostname garbage;
do
        if [[ -n "$ip" && "$ip" =~ ^[0-9] ]]; then

                ip_corect=$(nslookup "$hostname" | grep 'Address:' | head -n -1 | tail -n 1 | awk '{print $2}')

                if [[ -n "$ip_corect" ]]; then

                        if [[ "$ip" != "$ip_corect" ]]; then

                                echo "Bogus IP for $hostname in /etc/hosts!"
                        fi
                fi
        fi
done  
