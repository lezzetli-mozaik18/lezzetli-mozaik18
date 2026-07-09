#!/bin/bash

if [ -f "/opt/lezzetli-mozaik18/lm18-bash-dispmgr-v0-1.sh" ]; then
	printf ""
else
	echo "fatal: DisplayManager absent"
	exit 1
fi

displaymanager="/opt/lezzetli-mozaik18/lm18-bash-dispmgr-v0-1.sh"
dpmg() {

bash "$displaymanager" "$1"

}

BASE="/opt/lezzetli-mozaik18"
DEST="$BASE/mounted"

echo "mount.sh"
if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
cat /opt/lezzetli-mozaik18/version.txt | dpmg -s
else
echo "fatal: Version information not available. Are you sure that the core package was imported successfully?" | dpmg -W
echo "Exiting in five seconds..." | dpmg -s
sleep 5
exit 0
fi

pkg="$1"

if [ -z "$pkg" ]; then
    echo "No package provided" | dpmg -s
    exit 1
fi

name="$(basename "$pkg" | cut -d. -f1)"

echo "Mounting: $name" | dpmg -s

mkdir -p "$DEST/$name"

tar -xf "$pkg" -C "$DEST/$name"

echo "Mounted -> $DEST/$name" | dpmg -s

exit 0
