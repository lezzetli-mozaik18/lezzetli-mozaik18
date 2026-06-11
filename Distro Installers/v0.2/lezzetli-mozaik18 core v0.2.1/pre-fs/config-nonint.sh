#!/bin/bash

ACTION="$1"
ARG="$2"

case "$ACTION" in

"rename_entry")
    if [ -z "$ARG" ]; then
        echo "No name provided. Enter new CLI name:"
        read -p " -> " ARG
    fi

    if [ -f "/usr/local/bin/lezzetli-mozaik18" ]; then
        sudo mv /usr/local/bin/lezzetli-mozaik18 "/usr/local/bin/$ARG"
        rm -f /opt/lezzetli-mozaik18/originality.verif
        echo "Renamed CLI entry to $ARG"
    else
        echo "CLI entry not found."
    fi
    ;;

"list_bin")
    ls /usr/local/bin | grep "l"
    ;;

"open_bin")
    cd /usr/local/bin || exit
    exec bash
    ;;

*)
    echo "Usage:"
    echo "  config-nonint.sh rename_entry <name>"
    echo "  config-nonint.sh list_bin"
    echo "  config-nonint.sh open_bin"
    ;;
esac
