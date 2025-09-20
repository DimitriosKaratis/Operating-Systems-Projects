#!/bin/bash

# IN ORDER FOR THE CODE TO FUNCTION AS IT SHOULD THE USER MUST HAVE A "usernames.txt" FILE IN HIS quiz-3 folder. ALSO IT SHOULD BE CALLED LIKE SO:
# ./myscript.sh <usernames_file> <filename>

echo ""

# Check if the required arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <usernames_file> <filename>"
    exit 1
fi

# Arguments
usernames_file=$1
target_file=$2

# Check if the usernames file exists
if [ ! -f "$usernames_file" ]; then
    echo "Usernames file not found: $usernames_file"
    exit 1
fi

# Read each username from the file
while IFS= read -r username; do
    echo "$username"
    echo "##########"

    # Get the user's home directory
    user_home=$(eval echo "~$username")

    # Check if the home directory exists
    if [ ! -d "$user_home" ]; then
        echo "$target_file: Permission denied."
    else
        # Check if the target file exists in the user's home directory
        file_path="$user_home/$target_file"
        if [ -e "$file_path" ]; then
            file_size=$(stat -c%s "$file_path")
            echo "$target_file: File found, size $file_size bytes."
        else
            echo "$target_file: File not found."
        fi
    fi

    # Print a blank line between each user's output
    echo ""
done < "$usernames_file"

