#!/bin/bash

echo "lezzetli18 Core v0.2 - Shell Permission Bootstrap"
echo "------------------------------------------------"

# Locate where this script is running from
BASE_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Scanning from:"
echo "$BASE_SRC"
echo

if [ ! -d "$BASE_SRC" ]; then
    echo "Error: base directory not found."
    exit 1
fi

echo "Making all .sh files executable..."
echo

count=0

# Recursive scan for .sh files
while IFS= read -r file; do
    if [ -f "$file" ]; then
        chmod +x "$file"
        echo "✔ $(realpath "$file")"
        ((count++))
    fi
done < <(find "$BASE_SRC" -type f -name "*.sh")

echo
echo "Done."
echo "Total scripts fixed: $count"

exit 0
