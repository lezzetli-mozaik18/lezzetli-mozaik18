#!/bin/bash

echo
echo "Welcome to the core v0.1.1 installer."
echo "This is the standalone installer. The software will be installed instantly without need for other files."
read -p "Install? (y/n) -> " ins 
case "$ins" in
n) exit 0 ;;
y)
# permission granting
echo
sudo echo "Root access granted"
# create directories & files
sudo mkdir -p /opt/lezzetli-mozaik18
sudo mkdir -p /opt/lezzetli-mozaik18/err
sudo mkdir -p /opt/lezzetli-mozaik18/methods
sudo mkdir -p /opt/lezzetli-mozaik18/mounted
sudo touch /opt/lezzetli-mozaik18/lpkg.sh
sudo touch /opt/lezzetli-mozaik18/lmpt.sh
sudo touch /opt/lezzetli-mozaik18/mount.sh
sudo touch /opt/lezzetli-mozaik18/on1.bash18
sudo touch /opt/lezzetli-mozaik18/directory.bash18
sudo touch /opt/lezzetli-mozaik18/repository.bash18
sudo touch /opt/lezzetli-mozaik18/method.bash18
sudo touch /opt/lezzetli-mozaik18/methods/example.m18
sudo touch /opt/lezzetli-mozaik18/version.txt
sudo touch /usr/local/bin/lezzetli-mozaik18
sudo touch /usr/local/bin/ldoc
sudo touch /usr/local/bin/lconf
# make edits
sudo cat << 'EOF' > /opt/lezzetli-mozaik18/lpkg.sh
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
    read -p "  What repository is it? -> https://github.com" repo

    echo "https://github.com$repo" | sudo tee "/opt/lezzetli-mozaik18/repository.bash18" > /dev/null
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
EOF
sudo cat << 'EOF' > /opt/lezzetli-mozaik18/lmpt.sh
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
EOF
sudo cat << 'EOF' > /opt/lezzetli-mozaik18/mount.sh
#!/bin/bash

ARCHIVE="$1"

if [ -z "$ARCHIVE" ]; then
    echo "No input"
    exit 1
fi

if [ ! -f "$ARCHIVE" ]; then
    echo "Error: file not found"
    exit 1
fi

case "$ARCHIVE" in
    *.tar|*.tar.xz|*.tar.gz)
        ;;
    *)
        echo "Unsupported format"
        exit 1
        ;;
esac

read -p "Package name  -> " name

BASE="/opt/lezzetli-mozaik18/mounted"
DEST="$BASE/$name"

sudo mkdir -p "$DEST"

echo "Extracting package..."

# extract INTO folder
sudo tar -xf "$ARCHIVE" -C "$DEST"

echo "Package mounted at: $DEST"
sleep 2

exit 0
EOF
sudo cat << 'EOF' > /opt/lezzetli-mozaik18/version.txt
lezzetli-mozaik18 Core v0.1.1
EOF
sudo cat << 'EOF' > /usr/local/bin/lezzetli-mozaik18
#!/bin/bash

BASE="/opt/lezzetli-mozaik18"

cmd="$1"
sub="$2"
arg="$3"

case "$cmd" in

lpkg)
    sudo bash "$BASE/lpkg.sh"
    ;;

lmpt)

    echo "Be careful please..."

    case "$sub" in

        -bash18)
            file="$arg"
            sudo nano "$BASE/$file.bash18"
            ;;

        -m18)
            file="$arg"
            sudo nano "$BASE/$file.m18"
            ;;

        *)
            sudo bash "$BASE/lmpt.sh"
            ;;
    esac
    ;;

pkg18)

    case "$sub" in

        -get)
            pkg="$arg"

            if [ -z "$pkg" ]; then
                echo "Usage: pkg18 -get <name>"
                exit 1
            fi

            if [ -d "$BASE/mounted/$pkg" ]; then
                cp -r "$BASE/mounted/$pkg" "$HOME/"
                echo "Package moved to $HOME/$pkg"
            else
                echo "Package not found."
                exit 1
            fi
            ;;

        -del)
            pkg="$arg"

            if [ -z "$pkg" ]; then
                echo "Usage: pkg18 -del <name>"
                exit 1
            fi

            sudo rm -rf "$BASE/mounted/$pkg"
            echo "Deleted package: $pkg"
            ;;

        -ls)
            ls "$BASE/mounted" 2>/dev/null || echo "No packages found."
            exit 0
            ;;
    esac
    ;;

quickmount)
    read -p "Package path -> " path
    sudo bash "$BASE/mount.sh" "$path"
    ;;

more)
    echo "lezzetli-mozaik18 CLI"
    echo
    echo "lconf - configure system"
    echo "ldoc  - system doctor"
    echo
    ;;

help|*)
    echo "lezzetli-mozaik18 CLI"
    echo
    echo "Commands:"
    echo "  lpkg"
    echo "  lmpt [-bash18 name | -m18 name]"
    echo "  pkg18 -get <name>"
    echo "  pkg18 -del <name>"
    echo "  pkg18 -ls"
    echo "  quickmount"
    echo "  help"
    echo
    echo 'Use "lezzetli-mozaik18 more" to view extra commands.'
    ;;
esac
EOF
sudo cat << 'EOF' > /usr/local/bin/ldoc
#!/bin/bash

BASE="/opt/lezzetli-mozaik18"

echo "lezzetli18 system doctor"
echo "------------------------"

check() {
    if [ -e "$1" ]; then
        echo "OK  -> $2"
    } else {
        echo "FAIL-> $2"
    }
}

check "$BASE" "Core directory"
check "$BASE/lpkg.sh" "GUI installer (lpkg)"
check "$BASE/lmpt.sh" "Engine (lmpt)"
check "$BASE/mount.sh" "Mount system"
check "$BASE/mounted" "Package storage"
check "/usr/local/bin/lezzetli-mozaik18" "CLI entry"

echo
echo "Mounted packages:"
ls "$BASE/mounted" 2>/dev/null || echo "none"
echo
echo "System check complete."
exit 0
EOF
sudo cat << 'EOF' > /usr/local/bin/lconf
#!/bin/bash
BASE="/opt/lezzetli-mozaik18"
echo "lezzetli18 configuration tool"
echo
echo "Available config files:"
ls "$BASE"/*.bash18 2>/dev/null
echo
read -p "Enter file name (without path, no extension) -> " file
TARGET="$BASE/$file.bash18"
if [ ! -f "$TARGET" ]; then
echo "File not found: $TARGET"
exit 1
fi
echo "Opening: $TARGET"
sudo nano "$TARGET"
echo "Done."
exit 0
EOF
sudo chmod +x /opt/lezzetli-mozaik18/lpkg.sh
sudo chmod +x /opt/lezzetli-mozaik18/lmpt.sh
sudo chmod +x /opt/lezzetli-mozaik18/mount.sh
sudo chmod +x /opt/lezzetli-mozaik18/methods/example.m18
sudo chmod +x /usr/local/bin/lezzetli-mozaik18
sudo chmod +x /usr/local/bin/ldoc
sudo chmod +x /usr/local/bin/lconf
echo
echo "Process complete! Run 'lezzetli-mozaik18' in bash. If there are any errors, consider checking the files or reinstalling."
exit 0

