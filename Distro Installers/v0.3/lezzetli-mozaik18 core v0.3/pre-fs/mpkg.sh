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

dpmg -n
echo "mpkg.sh"
echo
echo "Please enter the name of the package you would like to move: " | dpmg -M
read -p " -> " pkg
if [ -d "/opt/lezzetli-mozaik18/mounted/$pkg" ]; then
echo 
echo " 1.  Move to a user's home directory" | dpmg -m
echo " 2.  Move to an absolute path"| dpmg -m
read -p " -> " pref
case "$pref" in 
1)
echo
echo "User: " | dpmg -s
read -p " -> " userp
if [ -d "/home/$userp" ]; then
if [ -d "/home/$userp/Desktop" ]; then
sudo cp -r "/opt/lezzetli-mozaik18/mounted/$pkg" "/home/$userp/Desktop/"
exit 0
else
echo "User's desktop directory does not exist." | dpmg -s
exit 0
fi
else
echo "User does not exist." | dpmg -s
exit 0
fi
;;
2)
echo "Path: "
read -p " -> " path
if [ -d "$path" ]; then
sudo cp -r "/opt/lezzetli-mozaik18/mounted/$pkg" "$path/"
exit 0
else
echo "Path does not exist." | dpmg -s
exit 0
fi
;;
*)
echo "unknown" | dpmg -s
exit 0
;;
esac
exit 0
else
echo "Package does not exist." | dpmg -W
exit 0
fi
