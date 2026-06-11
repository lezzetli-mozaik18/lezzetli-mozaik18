#!/bin/bash

STATE="/opt/lezzetli-mozaik18/state"

echo "lpkg.sh"
if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
cat /opt/lezzetli-mozaik18/version.txt
else
echo "fatal: Version information not available. Are you sure that the core package was imported successfully?"
echo "Exiting in five seconds..."
sleep 5
exit 0
fi

echo "Welcome to the lezzetli-mozaik18 distribution installer GUI! Please choose a method to install your package:"
echo "1) Local"
echo "2) GitHub"
echo "3) Method"
echo "4) Exit"

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
