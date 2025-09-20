#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 usernames_file filename"
    exit 1
fi

usernames_file=$1
filename=$2

if [ ! -f "$usernames_file" ]; then
    echo "Error: File $usernames_file does not exist."
    exit 1
fi

while IFS= read -r username; do
    echo "$username"
    echo "##########"

    home_dir="/home/$username"
    if [ ! -d "$home_dir" ]; then
        echo "$filename: Permission denied."
        continue
    fi

    file_path="$home_dir/$filename"
    if [ ! -e "$file_path" ]; then
        echo "$filename: File not found."
    else
        file_size=$(stat -c%s "$file_path" 2>/dev/null)
        if [ $? -eq 0 ]; then
            echo "$filename: File found, size $file_size bytes."
        else
            echo "$filename: Permission denied."
        fi
    fi
    echo ""
done < "$usernames_file"

