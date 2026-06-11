#!/bin/bash

echo "install vDemo.sh"
echo
echo "  lcheck Demo"
groups | grep -e "sudo"
sudo touch "/usr/local/bin/lcheck"
sudo chmod +x "/usr/local/bin/lcheck"
sudo cat << 'EOF' > "/usr/local/bin/lcheck"
#!/bin/bash

# Ensure the script is executed with the input file path argument
if [ -z "$1" ]; then
    echo "Error: Missing input file path argument." >&2
    echo "Usage: lcheck </path/to/file.cmap>" >&2
    exit 1
fi

# Target file path provided directly by $1
CMAP_FILE="$1"

# Check if the exact target file exists before starting
if [ ! -f "$CMAP_FILE" ]; then
    echo "Error: Package map file '$CMAP_FILE' not found." >&2
    exit 1
fi

echo "=========================================="
echo " Starting Package Checkup for $CMAP_FILE"
echo "=========================================="

total_checked=0
total_missing=0

# Read the exact target file line-by-line using a safe IFS loop
while IFS= read -r line || [ -n "$line" ]; do
    # Skip completely empty lines or lines starting with a comment sign (#)
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

    remaining_text="$line"
    delimiter="%**%"

    # Manual window-clipping loop to parse tokens literally without array splitting
    while [[ -n "$remaining_text" ]]; do
        
        # If the string starts with the delimiter, strip it and advance
        if [[ "$remaining_text" == "$delimiter"* ]]; then
            remaining_text="${remaining_text#"$delimiter"}"
            continue
        fi

        # Isolate the directory path up to the next delimiter token
        if [[ "$remaining_text" == *"$delimiter"* ]]; then
            # Extract everything before the first delimiter occurrence
            current_dir="${remaining_text%%"$delimiter"*}"
            # Retain everything after the first delimiter occurrence
            remaining_text="${remaining_text#*"$delimiter"}"
        else
            # No more delimiters found, consume the remaining data
            current_dir="$remaining_text"
            remaining_text=""
        fi

        # Drop out if the parsed element is empty
        [ -z "$current_dir" ] && continue

        ((total_checked++))

        # Direct filesystem evaluation of the exact directory string
        if [ -d "$current_dir" ]; then
            printf "  %-60s [ EXISTS ]\n" "$current_dir"
        else
            printf "  %-60s [ MISSING ]\n" "$current_dir"
            ((total_missing++))
        fi
    done

done < "$CMAP_FILE"

echo "=========================================="
echo " Checkup finished."
echo " Total Directories Checked: $total_checked"
echo " Total Directories Missing: $total_missing"
echo "=========================================="

# Return error exit status if files are missing
if [ "$total_missing" -gt 0 ]; then
    exit 1
fi

exit 0
EOF
echo "done"
exit 0
