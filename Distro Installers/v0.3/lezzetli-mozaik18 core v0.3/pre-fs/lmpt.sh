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
STATE="$BASE/state"

dpmg -n
echo "lmpt.sh"
echo
if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
cat /opt/lezzetli-mozaik18/version.txt | dpmg -M
else
echo "fatal: Version information not available. Are you sure that the core package was imported successfully?" | dpmg -W
echo "Exiting in five seconds..." | dpmg -s
sleep 5
exit 0
fi

mode=$(cat "$STATE/on.bash18" 2>/dev/null)

case "$mode" in

1)
    dir=$(cat "$STATE/directory.bash18")
    echo "Mounting local package..." | dpmg -s
    sudo bash "$BASE/mount.sh" "$dir"
    ;;

2)
    repo=$(cat "$STATE/repository.bash18")
    echo "Cloning repo..." | dpmg -s
    git clone "$repo"
    ;;

3)
    method=$(cat "$STATE/method.bash18")
    echo "Running method: $method" | dpmg -s
    sudo bash "$BASE/methods/$method.m18"
    ;;

*)
    echo "Invalid or missing state" | dpmg -W
    sudo touch /opt/lezzetli-mozaik18/err/no_descriptor!
    exit 1
    ;;
esac
