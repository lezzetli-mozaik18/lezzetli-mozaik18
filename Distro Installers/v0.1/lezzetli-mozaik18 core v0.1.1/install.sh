#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_TARGET="/usr/local/bin"
OPT_TARGET="/opt/lezzetli-mozaik18"

sudo bash "$BASE_DIR/prepare package.sh"

echo "Base dir: $BASE_DIR"

if [ -d "$OPT_TARGET" ]; then

echo "A lezzetli18 installer already exists. Otherwise, a directory named /opt/lezzetli-mozaik18 exists, which should not. If so, please delete the directory and try again for an errorless experience."

if [ -f "$OPT_TARGET/version.txt" ]; then
    echo
    sudo cat "$OPT_TARGET/version.txt"
    echo
else
    echo
    echo "Version information not included within the installer."
    echo
fi

read -p "Overwrite / Cancel -> " pref

case "$pref" in

    Overwrite)

        echo "Please beware! Are you informed that all data within this existing installer/directory will be erased? Please ensure safety of valuable data."

        read -p "y / n -> " safety

        if [ "$safety" = "y" ]; then

            sudo rm -rf "$OPT_TARGET"
            sudo mkdir -p "$OPT_TARGET"

            # -------------------------
            # PRE-FS
            # -------------------------
            if [ -d "$BASE_DIR/pre-fs" ]; then

                echo "Moving pre-fs files..."

                for file in "$BASE_DIR/pre-fs/"*; do
                    [ -f "$file" ] || continue

                    sudo cp "$file" "$OPT_TARGET/"
                    echo "Copied: $(basename "$file")"
                done

            else
                echo "fatal:"
                echo "No pre-fs folder found. Are you sure the package was imported correctly?"
                echo "Exiting automatically in five seconds..."
                sleep 5
                exit 1
            fi

            # -------------------------
            # BIN
            # -------------------------
            if [ -d "$BASE_DIR/bin" ]; then

                echo "Installing bin commands..."

                for file in "$BASE_DIR/bin/"*; do
                    [ -f "$file" ] || continue

                    fname="$(basename "$file")"

                    chmod +x "$file"
                    sudo cp "$file" "$BIN_TARGET/$fname"

                    echo "Installed command: $fname"
                done

            else
                echo "fatal:"
                echo "No bin folder found. Are you sure the package was imported correctly?"
                echo "Exiting automatically in five seconds..."
                sleep 5
                exit 1
            fi

            echo
            echo "Overwrite complete."

        elif [ "$safety" = "n" ]; then

            echo
            echo "Cancelling..."
            sleep 1
            exit 0

        else

            echo
            echo "Unknown parameter."
            sleep 1
            exit 1

        fi
        ;;

    Cancel)
        exit 0
        ;;

    *)
        echo
        echo "Unknown parameter. Please try again."
        sleep 3
        exit 1
        ;;

esac
```

else

```
echo
echo "Starting setup process in 3 seconds..."
sleep 3

sudo mkdir -p "$OPT_TARGET"

# -------------------------
# PRE-FS
# -------------------------
if [ -d "$BASE_DIR/pre-fs" ]; then

    echo "Moving pre-fs files..."

    for file in "$BASE_DIR/pre-fs/"*; do
        [ -f "$file" ] || continue

        sudo cp "$file" "$OPT_TARGET/"
        echo "Copied: $(basename "$file")"
    done

else
    echo "fatal:"
    echo "No pre-fs folder found."
    exit 1
fi

# -------------------------
# BIN
# -------------------------
if [ -d "$BASE_DIR/bin" ]; then

    echo "Installing bin commands..."

    for file in "$BASE_DIR/bin/"*; do
        [ -f "$file" ] || continue

        fname="$(basename "$file")"

        chmod +x "$file"
        sudo cp "$file" "$BIN_TARGET/$fname"

        echo "Installed command: $fname"
    done

else
    echo "fatal:"
    echo "No bin folder found."
    exit 1
fi

echo
echo "Installation complete."

fi
bash "$BASE_DIR/end setup.sh"
exit 0

