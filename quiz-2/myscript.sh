#!/bin/bash

# IN ORDER FOR THE CODE TO FUNCTION AS IT SHOULD THE USER MUST HAVE A "usernames.txt" FILE IN HIS quiz-2 folder.


# Define the path to the file containing usernames
filename="usernames.txt"  # Replace with the actual file path

# Ensure the file exists
if [ ! -f "$filename" ]; then
    echo "File not found: $filename"
    exit 1
fi

# Read all usernames into an array
mapfile -t usernames < "$filename"

# Process each username
for i in "${!usernames[@]}"; do
    username="${usernames[$i]}"
    # Skip empty lines
    [ -z "$username" ] && continue

    # Get login dates with month names, avoiding newline at the end
    login_dates=$(last "$username" | grep -v "tty" | grep -v "reboot" | grep -v "wtmp" | head -n 20 | \
        awk '{dates[NR] = $4 " " $5 " " $6 " " $7}
             END {
                 for (i = 1; i <= NR; i++) {
                     printf "%s", dates[i]
                     if (i < NR) printf "\n"
                 }
             }' | sed 's/still//' | sed 's/-//')

    # Get login IPs
    login_ips=$(last -i "$username" | grep -v "tty" | grep -v "reboot" | grep -v "wtmp" | head -n 20 | \
        awk '{print $3}' | grep -v "^$")

    # Only display users that have login information
    if [ ! -z "$login_dates" ] || [ ! -z "$login_ips" ]; then
        # Username
        echo "$username"
        # Separator line with exactly 10 #
        echo "##########"

        # Add a blank line after the separator only for the last user
        if [ $((i + 1)) -eq ${#usernames[@]} ]; then
            echo ""
        fi
        
	# Login dates section
        echo "Last login date(s):"
        if [ ! -z "$login_dates" ]; then
            # Print dates without any trailing newline
            echo "$login_dates" | awk '{if(NR==1)printf "%s", $0; else printf "\n%s", $0}'
        fi
        printf "\b\b\b...\n"

        # Login IPs section
        echo "Last login IP(s)/hostname(s):"
        if [ ! -z "$login_ips" ]; then
            while read -r ip; do
                if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                    # Print IP with consistent formatting
                    echo "$ip"
                    # Try to get hostname
                    hostname=$(host "$ip" 2>/dev/null | awk '{print $NF}' | sed 's/\.$//')
                    if [ ! -z "$hostname" ] && [ "$hostname" != "3(NXDOMAIN)" ]; then
                        echo "$hostname"
                    else
                        echo "host.example.com"  # Default hostname if none resolves
                    fi
                elif [[ $ip != "in" && $ip != "system" && ! -z "$ip" ]]; then
                    echo "$ip"
                    echo "host.example.com"  # Add default hostname for non-IP entries
                fi
            done <<< "$login_ips"
        fi
        echo "..."
    fi

    # Add a blank line between users except for the last one
    if [ $((i + 1)) -lt ${#usernames[@]} ]; then
        echo ""
    fi
done
