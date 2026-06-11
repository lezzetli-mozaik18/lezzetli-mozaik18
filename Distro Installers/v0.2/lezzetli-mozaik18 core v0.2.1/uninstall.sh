#!/bin/bash

BASE="/opt/lezzetli-mozaik18"

echo "lezzetli18 Core v0.2 Uninstaller"
echo "--------------------------------"
echo "This will remove:"
echo "  - Core system files (/opt/lezzetli-mozaik18)"
echo "  - CLI entry (/usr/local/bin/lezzetli-mozaik18)"
echo "  - lconf"
echo "  - ldoc"
echo

read -p "Are you sure? (y/n) -> " confirm

case "$confirm" in
    y|Y)

        echo "Removing CLI tools..."
        sudo rm -f /usr/local/bin/lezzetli-mozaik18
        sudo rm -f /usr/local/bin/lconf
        sudo rm -f /usr/local/bin/ldoc

        echo "Removing Core directory..."
        sudo rm -rf "$BASE"

        echo
        echo "Uninstall complete."
        echo "System removed successfully."
        ;;

    n|N)
        echo "Cancelled."
        exit 0
        ;;

    *)
        echo "Invalid input."
        exit 1
        ;;
esac

exit 0
