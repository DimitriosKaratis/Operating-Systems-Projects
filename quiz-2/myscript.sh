#!/bin/bash

if [ -z "$1" ]; then
    argument1="usernames.txt"
else
    argument1="$1"
fi

if [ ! -f "$argument1" ]; then
    echo "File '$argument1' not found!"
    exit 1
fi

while read username; do
    echo "$username"
    echo "##########"
    echo "Last login date(s):"
    last "$username" | grep -v "wtmp begins" | awk '{print $4, $5, $6, $7}' | head -n 20 | sed 's/^//'
    printf "\033[F...\n"
    echo "Last login IP(s)/hostname(s):"
    last "$username" | grep -v "wtmp begins" | awk '{print $3}' | head -n 20 | while read -r ip; do
        if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            resolved=$(host "$ip" 2>/dev/null | awk '/domain name pointer/ {print $5}' | sed 's/\.$//')
            echo "$ip"
            echo "${resolved:-host.example.com}"
        else
            echo "$ip"
        fi
    done
    printf "\033[F...\n"
    echo
done < "$argument1"
                    
