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
echo "config.sh"
echo

# Version display
if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
    cat "/opt/lezzetli-mozaik18/version.txt" | dpmg -M
else
    echo "fatal: Version information not found." | dpmg -W
    exit 1
fi

echo
echo "1. Base filesystem settings" | dpmg -m
echo "2. CLI entry settings" | dpmg -m
echo "3. Exit" | dpmg -m

read -p " -> " pref

case "$pref" in

1)
    echo
    echo "1. Navigate" | dpmg -m
    echo "2. Browse files" | dpmg -m
    echo "3. Edit file with nano" | dpmg -m
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
    echo "1. Rename CLI entry" | dpmg -m
    echo "2. Open CLI directory" | dpmg -m
    echo "3. List executables" | dpmg -m

    read -p " -> " opt

    case "$opt" in

    1)
        if [ -f "/usr/local/bin/lezzetli-mozaik18" ]; then
            echo
            echo "WARNING: Renaming CLI entry affects how you launch the system." | dpmg -W
            dpmg -n
            read -p "New name (or type cancel): " rename

            if [ "$rename" != "cancel" ]; then
                sudo mv /usr/local/bin/lezzetli-mozaik18 "/usr/local/bin/$rename"
                echo "CLI renamed to $rename" | dpmg -W
            fi
        else
            echo "CLI entry not found." | dpmg -s
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
    echo "Exiting..." | dpmg -s
    exit 0
    ;;

*)
    echo "Invalid option." | dpmg -s
    ;;
esac
