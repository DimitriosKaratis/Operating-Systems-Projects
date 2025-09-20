#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <4-digit-integer>"
    exit 1
fi

if ! [[ $1 =~ ^[0-9]{4}$ ]]; then
    echo "Please provide a 4-digit integer to be an AEM (last 4 digits)."
    exit 1
fi

input=$1
echo -n $input | sha256sum | awk '{print $1}'
