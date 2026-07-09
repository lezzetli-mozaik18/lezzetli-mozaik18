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

STATE="/opt/lezzetli-mozaik18/state"

echo "lpkg.sh"

dpmg -n

if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
cat /opt/lezzetli-mozaik18/version.txt | dpmg -s
else
echo "fatal: Version information not available. Are you sure that the core package was imported successfully?" | dpmg -W
echo "Exiting in five seconds..." | dpmg -s
sleep 5
exit 0
fi

echo "dpmg-active" | dpmg -M
echo "Welcome to the lezzetli-mozaik18 distribution installer GUI! Please choose a method to install your package:" | dpmg -s
dpmg -n
echo "1) Local" | dpmg -m
echo "2) GitHub" | dpmg -m
echo "3) Method" | dpmg -m
echo "4) Exit" | dpmg -m

read -p "-> " opt

echo "$opt" > "$STATE/on.bash18"

case "$opt" in

1)
    read -p "Path -> " p
    echo "$p" > "$STATE/directory.bash18"
    ;;

2)
    read -p "Repo -> " r
    echo "$r" > "$STATE/repository.bash18"
    ;;

3)
    read -p "Method name -> " m
    echo "$m" > "$STATE/method.bash18"
    ;;

4)
    exit 0
    ;;
esac

sudo bash /opt/lezzetli-mozaik18/lmpt.sh
exit 0
