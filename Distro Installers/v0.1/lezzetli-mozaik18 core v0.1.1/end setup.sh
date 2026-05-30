#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Saving uninstall tool..."

# ensure target exists
sudo mkdir -p /opt/lezzetli-mozaik18

# move uninstall script into system as remove.sh
if [ -f "$BASE_DIR/uninstall.sh" ]; then
    sudo cp "$BASE_DIR/uninstall.sh" /opt/lezzetli-mozaik18/remove.sh
    sudo chmod +x /opt/lezzetli-mozaik18/remove.sh
    echo "Saved as /opt/lezzetli-mozaik18/remove.sh"
else
    echo "uninstall.sh not found"
fi

# remove installer directory (cleanup)
echo "Cleaning installer directory..."
sudo rm -rf "$BASE_DIR"

echo "Done."
exit 0
