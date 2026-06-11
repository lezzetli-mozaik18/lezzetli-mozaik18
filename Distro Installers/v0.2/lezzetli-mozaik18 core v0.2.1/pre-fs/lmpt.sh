#!/bin/bash

BASE="/opt/lezzetli-mozaik18"
STATE="$BASE/state"

echo "lmpt.sh"
echo
if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
cat /opt/lezzetli-mozaik18/version.txt
else
echo "fatal: Version information not available. Are you sure that the core package was imported successfully?"
echo "Exiting in five seconds..."
sleep 5
exit 0
fi

mode=$(cat "$STATE/on.bash18" 2>/dev/null)

case "$mode" in

1)
    dir=$(cat "$STATE/directory.bash18")
    echo "Mounting local package..."
    sudo bash "$BASE/mount.sh" "$dir"
    ;;

2)
    repo=$(cat "$STATE/repository.bash18")
    echo "Cloning repo..."
    git clone "$repo"
    ;;

3)
    method=$(cat "$STATE/method.bash18")
    echo "Running method: $method"
    sudo bash "$BASE/methods/$method.m18"
    ;;

*)
    echo "Invalid or missing state"
    sudo touch /opt/lezzetli-mozaik18/err/no_descriptor!
    exit 1
    ;;
esac
