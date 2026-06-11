#!/bin/bash

echo "install vDemo.sh"
echo
echo "  venture Demo"
echo "You may be asked for admin privileges."
groups | grep -e "sudo"
echo

if [ -d "/usr/local/bin" ]; then
sudo cat << 'EOF' > "/usr/local/bin/venture"
#!/bin/bash

# Establish initial target directory
if [ -z "$1" ]; then
    cd "/" || exit 1
else
    cd "$1" || exit 1
fi

# Run engine inside a clean loop to prevent memory stack overflows
while true; do
    # Clear screen feedback per directory hop
    current_dir=$(pwd)
    echo "Current Location: $current_dir"
    echo "------------------------------------------"
    ls -F
    echo

    read -p "Select: " selection

    case "$selection" in
        ^help)
            echo "Commands: ^back or ^b | ^nano | ^exit"
            echo
            ;;
        ^b|^back)
            # Safely step out to the parent directory
            if [ "$current_dir" != "/" ]; then
                cd ..
            else
                echo "Already at system root directory."
                echo
            fi
            ;;
        ^nano)
            read -p "Edit file name: " nano_target
            if [ -n "$nano_target" ]; then
                nano "$nano_target"
            fi
            ;;
        ^exit)
            exit 0
            ;;
        "")
            # Handle empty enter presses gracefully
            ;;
        *)
            # Standard directory traversal target selection
            if [ -d "$selection" ]; then
                cd "$selection"
            elif [ -f "$selection" ]; then
                echo "Error: '$selection' is a file. Use ^nano to edit files."
                echo
            else
                echo "Error: Directory or file '$selection' not found."
                echo
            fi
            ;;
    esac
done
EOF

    # Grant binary execution permissions post-write
    sudo chmod +x "/usr/local/bin/venture"
    echo "done"
else
    echo "fatal: /usr/local/bin not found"
    exit 1
fi

exit 0
