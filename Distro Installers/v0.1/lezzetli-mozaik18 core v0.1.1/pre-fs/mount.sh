#!/bin/bash

ARCHIVE="$1"

if [ -z "$ARCHIVE" ]; then
    echo "No input"
    exit 1
fi

if [ ! -f "$ARCHIVE" ]; then
    echo "Error: file not found"
    exit 1
fi

case "$ARCHIVE" in
    *.tar|*.tar.xz|*.tar.gz)
        ;;
    *)
        echo "Unsupported format"
        exit 1
        ;;
esac

read -p "Package name  -> " name

BASE="/opt/lezzetli-mozaik18/mounted"
DEST="$BASE/$name"

sudo mkdir -p "$DEST"

echo "Extracting package..."

# extract INTO folder
sudo tar -xf "$ARCHIVE" -C "$DEST"

echo "Package mounted at: $DEST"
sleep 2

exit 0
