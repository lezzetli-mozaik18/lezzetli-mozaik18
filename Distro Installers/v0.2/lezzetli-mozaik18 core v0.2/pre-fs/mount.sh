#!/bin/bash

BASE="/opt/lezzetli-mozaik18"
DEST="$BASE/mounted"

echo "mount.sh"
if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
cat /opt/lezzetli-mozaik18/version.txt
else
echo "fatal: Version information not available. Are you sure that the core package was imported successfully?"
echo "Exiting in five seconds..."
sleep 5
exit 0
fi

pkg="$1"

if [ -z "$pkg" ]; then
    echo "No package provided"
    exit 1
fi

name="$(basename "$pkg" | cut -d. -f1)"

echo "Mounting: $name"

mkdir -p "$DEST/$name"

tar -xf "$pkg" -C "$DEST/$name"

echo "Mounted -> $DEST/$name"
