#!/bin/bash

echo
echo "(This is only a GUI. The real setup script is included elsewhere, in this GUI's folder by default.)"
echo
echo "Welcome to the lezzetli18 distribution installer. (!!) You may be asked for admin privileges."
echo "Please choose a method to setup a distro by its number:"
echo
echo "1. From this device"
echo "2. From Github"
echo "3. Other..."
echo "4. Exit"
echo

read -p " -> " on

if [ "$on" = "4" ]; then
    exit 0
fi

FILE="/opt/lezzetli-mozaik18/on.txt"

# ensure directory exists
sudo mkdir -p /opt/lezzetli-mozaik18

# write selection safely
if [ -f "$FILE" ]; then
    echo "$on" | sudo tee "$FILE" > /dev/null
else
    echo "fatal" | sudo tee "$FILE" > /dev/null
fi

sudo bash /opt/lezzetli-mozaik18/lmpt.sh

exit 0
