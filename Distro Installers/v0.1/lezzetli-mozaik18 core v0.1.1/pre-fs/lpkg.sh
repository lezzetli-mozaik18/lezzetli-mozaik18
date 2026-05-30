#!/bin/bash

echo "lpkg.sh"
if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
sudo cat "/opt/lezzetli-mozaik18/version.txt"
fi

echo "  Welcome to the lezzetli18 distribution installer. Please choose a method to install:"
echo
echo "    1.  From this device"
echo "    2.  From Github"
echo "    3.  Other... (import an installation method)"
echo "    4.  Exit"
echo

read -p "  (1/2/3/4)  -> " pref

case "$pref" in


1)
    echo
    read -p "  Where does the package exist?  -> " dir

    echo "$dir" | sudo tee "/opt/lezzetli-mozaik18/directory.bash18" > /dev/null
    echo "1" | sudo tee "/opt/lezzetli-mozaik18/on1.bash18" > /dev/null

    sudo bash "/opt/lezzetli-mozaik18/lmpt.sh"
    ;;

2)
    echo
    read -p "  What repository is it? -> https://github.com/lezzetli-mozaik18/" repo

    echo "https://github.com/lezzetli-mozaik18/$repo" | sudo tee "/opt/lezzetli-mozaik18/repository.bash18" > /dev/null
    echo "2" | sudo tee "/opt/lezzetli-mozaik18/on1.bash18" > /dev/null

    sudo bash "/opt/lezzetli-mozaik18/lmpt.sh"
    ;;

3)

    echo
    read -p "  Do you have an installation method already? (y/n)  -> " prep

    case "$prep" in

        y)

            echo "3" | sudo tee "/opt/lezzetli-mozaik18/on1.bash18" > /dev/null
            sudo bash "/opt/lezzetli-mozaik18/lmpt.sh"
            ;;

        n)

            echo
            read -p "  How would you like the method to be imported? (write now/select file)  -> " pref

            case "$pref" in

                "write now")

                    read -p "  What should be the name of this method?  -> " name

                    sudo mkdir -p "/opt/lezzetli-mozaik18/methods"

                    sudo nano "/opt/lezzetli-mozaik18/methods/$name.m18"
                    sudo chmod +x "/opt/lezzetli-mozaik18/methods/$name.m18"

                    echo "$name" | sudo tee "/opt/lezzetli-mozaik18/method.bash18" > /dev/null
                    echo "3" | sudo tee "/opt/lezzetli-mozaik18/on1.bash18" > /dev/null

                    sudo bash "/opt/lezzetli-mozaik18/lmpt.sh"
                    ;;

                "select file")

                    read -p "  Where is the m18 file located?  -> " dir

                    echo "$dir" | sudo tee "/opt/lezzetli-mozaik18/directory.bash18" > /dev/null
                    echo "3" | sudo tee "/opt/lezzetli-mozaik18/on1.bash18" > /dev/null

                    sudo bash "/opt/lezzetli-mozaik18/lmpt.sh"
                    ;;

                *)

                    echo "Unknown option."
                    ;;
            esac
            ;;

        *)

            echo "Unknown option."
            ;;
    esac
    ;;

4)

    echo
    echo "Exiting..."
    sleep 1
    ;;

*)

    echo
    echo "Unknown option."
    exit 1
    ;;

esac

exit 0

