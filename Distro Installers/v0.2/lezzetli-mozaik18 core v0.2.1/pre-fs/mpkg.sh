#!/bin/bash

echo "mpkg.sh"
echo
echo "Please enter the name of the package you would like to move: "
read -p " -> " pkg
if [ -d "/opt/lezzetli-mozaik18/mounted/$pkg" ]; then
echo 
echo " 1.  Move to a user's home directory"
echo " 2.  Move to an absolute path"
read -p " -> " pref
case "$pref" in 
1)
echo
echo "User: "
read -p " -> " userp
if [ -d "/home/$userp" ]; then
if [ -d "/home/$userp/Desktop" ]; then
sudo cp -r "/opt/lezzetli-mozaik18/mounted/$pkg" "/home/$userp/Desktop/"
exit 0
else
echo "User's desktop directory does not exist."
exit 0
fi
else
echo "User does not exist."
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
echo "Path does not exist."
exit 0
fi
;;
*)
echo "unknown"
exit 0
;;
esac
exit 0
else
echo "Package does not exist."
exit 0
fi
