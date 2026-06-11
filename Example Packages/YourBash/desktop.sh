#!/bin/bash

BASE="/usr/local/bin"

while true; do

CHOICE=$(whiptail --title "lezzetli-mozaik18 YourBash" \
--menu "Choose an action:" 15 60 5 \
"1" "Create entry" \
"2" "List entries" \
"3" "View entry" \
"4" "Delete entry" \
"5" "Exit" 3>&1 1>&2 2>&3)

case "$CHOICE" in

1)
    idpref=$(whiptail --inputbox "ENTRY ID:" 10 50 3>&1 1>&2 2>&3)
    content=$(whiptail --inputbox "ENTRY CONTENT:" 10 50 3>&1 1>&2 2>&3)

    echo "$content" | sudo tee "$BASE/$idpref" > /dev/null
    sudo chmod +x "$BASE/$idpref"

    whiptail --msgbox "Entry created: $idpref" 10 50
;;

2)
    ls "$BASE" | whiptail --textbox /dev/stdin 20 60
;;

3)
    idpref=$(whiptail --inputbox "ENTRY ID:" 10 50 3>&1 1>&2 2>&3)
    if [[ -f "$BASE/$idpref" ]]; then
        cat "$BASE/$idpref" | whiptail --textbox /dev/stdin 20 60
    else
        whiptail --msgbox "Not found" 10 40
    fi
;;

4)
    idpref=$(whiptail --inputbox "ENTRY ID:" 10 50 3>&1 1>&2 2>&3)
    sudo rm -f "$BASE/$idpref"
    whiptail --msgbox "Deleted" 10 40
;;

5)
    exit 0
;;

esac

done
