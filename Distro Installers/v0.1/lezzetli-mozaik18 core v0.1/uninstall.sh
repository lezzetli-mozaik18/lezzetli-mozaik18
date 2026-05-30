#!/bin/bash

echo "Uninstalling lezzetli-mozaik18..."

BIN_TARGET="/usr/local/bin"
OPT_TARGET="/opt/lezzetli-mozaik18"

# Remove bin commands (only ones related to project)
if [ -d "$BIN_TARGET" ]; then
    echo "Removing commands from /usr/local/bin..."

    # adjust names if you want strict filtering
    for file in "$BIN_TARGET"/*; do
        if [ -f "$file" ]; then
            name="$(basename "$file")"

            # safety check (only remove your tool)
            if [[ "$name" == lezzetli* ]]; then
                sudo rm -f "$file"
                echo "Removed: $name"
            fi
        fi
    done
fi

# Remove opt directory
if [ -d "$OPT_TARGET" ]; then
    sudo rm -rf "$OPT_TARGET"
    echo "Removed: $OPT_TARGET"
fi

echo "Uninstall complete."
exit 0
