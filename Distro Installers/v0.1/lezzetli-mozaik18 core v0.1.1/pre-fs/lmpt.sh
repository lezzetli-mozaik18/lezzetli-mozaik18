#!/bin/bash

echo "lmpt.sh"

min=1
max=3

rand=$(awk -v min="$min" -v max="$max" 'BEGIN {
    srand();
    print int(min + rand() * (max - min + 1))
}')

if [ -f "/opt/lezzetli-mozaik18/version.txt" ]; then
    echo
    sudo cat "/opt/lezzetli-mozaik18/version.txt"
else
    echo
    echo "fatal: Version information not available."
    sleep 3
    exit 0
fi

if [ -f "/opt/lezzetli-mozaik18/on1.bash18" ]; then
    echo
    sudo cat "/opt/lezzetli-mozaik18/on1.bash18"
else
    echo
    echo "fatal: on1.bash18 does not exist."
    sleep 3
    exit 0
fi

# ---------------- ERR FOLDER SAFETY ----------------

check_file() {
    local f="$1"
    local name="$2"

    if [ ! -f "$f" ]; then
        echo "$name missing"
        now=$(date +%Y%m%d-%H%M%S)
        sudo touch "/opt/lezzetli-mozaik18/err/$now-404-$name"
    else
        echo "$name exists"
    fi
}

check_file "/opt/lezzetli-mozaik18/directory.bash18" "directory.bash18"
check_file "/opt/lezzetli-mozaik18/repository.bash18" "repository.bash18"
check_file "/opt/lezzetli-mozaik18/method.bash18" "method.bash18"

pref=$(sudo cat "/opt/lezzetli-mozaik18/on1.bash18")

echo
echo "lmpt.sh process has begun"

case "$pref" in

    1)
        dir=$(sudo cat "/opt/lezzetli-mozaik18/directory.bash18")
        sudo bash "/opt/lezzetli-mozaik18/mount.sh" "$dir"
        exit 0
        ;;

    2)
        repo=$(sudo cat "/opt/lezzetli-mozaik18/repository.bash18")
        echo "Cloning Github repo..."
        git clone "$repo"
        echo "Done"
        exit 0
        ;;

    3)
        name=$(sudo cat "/opt/lezzetli-mozaik18/method.bash18")

        echo "Detecting method location..."
        sleep "$rand"

        method_path="/opt/lezzetli-mozaik18/methods/$name.m18"

        if [ -f "$method_path" ]; then
            echo "$method_path"
            read -p "Is this correct? (y/n) -> " tru

            case "$tru" in
                y)
                    sudo bash "$method_path"
                    exit 0
                    ;;
                n)
                    read -p "Enter absolute location -> " dir
                    read -p "Is this correct? (y/n) -> " tru2

                    case "$tru2" in
                        y)
                            sudo bash "$dir"
                            exit 0
                            ;;
                        *)
                            echo "Exiting..."
                            sleep 5
                            exit 0
                            ;;
                    esac
                    ;;
                *)
                    echo "invalid parameter"
                    exit 0
                    ;;
            esac
        else
            echo "Method not found."
            exit 0
        fi
        ;;

    *)
        echo "invalid parameter"
        exit 0
        ;;
esac

exit 0
