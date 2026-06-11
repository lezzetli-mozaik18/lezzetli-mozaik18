#!/bin/bash

echo "config.sh"
echo

# Version display
if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
    cat "/opt/lezzetli-mozaik18/version.txt"
else
    echo "fatal: Version information not found."
    exit 1
fi

echo
echo "1. Base filesystem settings"
echo "2. CLI entry settings"
echo "3. Exit"

read -p " -> " pref

case "$pref" in

1)
    echo
    echo "1. Navigate"
    echo "2. Browse files"
    echo "3. Edit file with nano"
    read -p " -> " opt

    case "$opt" in

    1)
        cd /opt/lezzetli-mozaik18 || exit
        exec bash
        ;;

    2)
        ls -lah /opt/lezzetli-mozaik18
        ;;

    3)
        ls /opt/lezzetli-mozaik18
        read -p "file -> " file
        sudo nano "/opt/lezzetli-mozaik18/$file"
        ;;

    esac
    ;;

2)
    echo
    echo "1. Rename CLI entry"
    echo "2. Open CLI directory"
    echo "3. List executables"

    read -p " -> " opt

    case "$opt" in

    1)
        if [ -f "/usr/local/bin/lezzetli-mozaik18" ]; then
            echo
            echo "WARNING: Renaming CLI entry affects how you launch the system."
            read -p "New name (or type cancel): " rename

            if [ "$rename" != "cancel" ]; then
                sudo mv /usr/local/bin/lezzetli-mozaik18 "/usr/local/bin/$rename"
                rm -f /opt/lezzetli-mozaik18/originality.verif
                echo "CLI renamed to $rename"
            fi
        else
            echo "CLI entry not found."
        fi
        ;;

    2)
        cd /usr/local/bin || exit
        exec bash
        ;;

    3)
        ls /usr/local/bin | grep "l"
        ;;

    esac
    ;;

3)
    echo "Exiting..."
    exit 0
    ;;

*)
    echo "Invalid option."
    ;;
esac
