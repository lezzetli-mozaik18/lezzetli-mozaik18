#!/bin/bash

set -e

echo "Installing lezzetli-mozaik18..."

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

BIN_TARGET="/usr/local/bin"
OPT_TARGET="/opt/lezzetli-mozaik18"

# ONLY create /opt/lezzetli-mozaik18
sudo mkdir -p "$OPT_TARGET"

echo "Base dir: $BASE_DIR"

# -------------------------
# PRE-FS (move as-is, no changes)
# -------------------------
if [ -d "$BASE_DIR/pre-fs" ]; then
    echo "Moving pre-fs files..."

    for file in "$BASE_DIR/pre-fs/"*; do
        [ -f "$file" ] || continue

        sudo cp "$file" "$OPT_TARGET/"
        echo "Copied: $(basename "$file")"
    done
else
    echo "No pre-fs folder found."
fi

# -------------------------
# BIN (make executable, move to /usr/local/bin)
# -------------------------
if [ -d "$BASE_DIR/bin" ]; then
    echo "Installing bin commands..."

    for file in "$BASE_DIR/bin/"*; do
        [ -f "$file" ] || continue

        fname="$(basename "$file")"

        chmod +x "$file"
        sudo cp "$file" "$BIN_TARGET/$fname"

        echo "Installed command: $fname"
    done
else
    echo "No bin folder found."
fi

echo
echo "Installation complete."
exit 0
