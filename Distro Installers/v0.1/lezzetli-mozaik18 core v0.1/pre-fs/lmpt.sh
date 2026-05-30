#!/bin/bash

echo "on.txt prints:"
cat /opt/lezzetli-mozaik18/on.txt
echo
echo

on=$(cat /opt/lezzetli-mozaik18/on.txt)
sleep 2

# OPTION 1 - From this device
if [ "$on" = "1" ]; then

    echo "Please enter the path to the lm18 file on your device..."
    read -p " -> " path

    if [ -f "$path" ]; then
        echo "$path" | sudo tee /opt/lezzetli-mozaik18/on1.txt > /dev/null
        echo "Saved local path successfully. You may use 'lezzetli-mozaik18 mount' to mount the distro."
    else
        echo "File does not exist or is not reachable."
        exit 1
    fi
fi


# OPTION 2 - From GitHub
if [ "$on" = "2" ]; then

    echo "Please enter the distro repository URL:"
    read -p " -> " repo

    read -p "Do you have git installed? (y/n): " tools

    if [ "$tools" = "y" ]; then

        if command -v git >/dev/null 2>&1; then
            git clone "$repo"
            echo "Repository cloned successfully."
        else
            echo "Git is not installed. Install it first."
            exit 1
        fi

    else
        echo "Git required to continue."
        exit 1
    fi
fi


# OPTION 3 - Other
if [ "$on" = "3" ]; then

    echo "Other installation method selected."
    echo "Please enter custom script or URL:"
    read -p " -> " input

    echo "$input" | sudo tee /opt/lezzetli-mozaik18/on2.txt > /dev/null

    echo "Saved custom input. You may use 'lezzetli-mozaik18 install -on2' to install via the supplied shell script."
    exit 0
fi


# OPTION 4 - Exit (handled anyway but kept for clarity)
if [ "$on" = "4" ]; then
    echo "Exiting installer..."
    exit 0
fi


# FINAL STEP (optional hook for your system)
echo
echo "Running post-install step..."
sleep 1

if [ -f /opt/lezzetli-mozaik18/post.sh ]; then
    sudo bash /opt/lezzetli-mozaik18/post.sh
else
    echo "No post-install script found."
fi

exit 0
