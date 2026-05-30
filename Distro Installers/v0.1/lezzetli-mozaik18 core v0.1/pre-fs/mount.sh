#!/bin/bash

FILE="/opt/lezzetli-mozaik18/on1.txt"
BASE="/opt/lezzetli-mozaik18/mounted"

if [ ! -f "$FILE" ]; then
    echo "Missing descriptor"
    exit 1
fi

NAME=$(cut -d'|' -f1 "$FILE")
ARCHIVE=$(cut -d'|' -f2 "$FILE")

TARGET="$BASE/$NAME"

mkdir -p "$TARGET"

echo "Mounting $NAME..."

# extract tar archive
tar -xf "$ARCHIVE" -C "$TARGET"

echo "Done: $TARGET"
