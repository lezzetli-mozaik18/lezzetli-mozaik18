#!/bin/bash

echo "run.sh"
read -p "This is a tool that replaces 'chmod +x' with 'run', as chmod is frequently used to give execution permissions. Please press enter to continue installing or CTRL+C to terminate the process." null

if [ -d "/usr/local/bin" ]; then
    # Create the binary file
    sudo touch "/usr/local/bin/run"
    
    # Write the script content with a valid shebang securely
    sudo cat << 'EOF' | sudo tee "/usr/local/bin/run" > /dev/null
#!/bin/bash
chmod +x "$1"
EOF

    # Grant execution permissions to the run tool itself
    sudo chmod +x "/usr/local/bin/run"
    echo "Installation complete: 'run' is ready to use."
else
    echo "fatal: /usr/local/bin not found"
    exit 1
fi

exit 0
