#!/bin/bash

echo "newuser.sh"
read -p "This is a tool that replaces 'adduser' with 'newuser', as sudo adduser is frequently used to create new users. Please press enter to continue installing or CTRL+C to terminate the process." null

if [ -d "/usr/local/bin" ]; then
    # Create the binary file
    sudo touch "/usr/local/bin/newuser"
    
    # Write the script content with a valid shebang securely
    sudo cat << 'EOF' > "/usr/local/bin/newuser"
#!/bin/bash
adduser "$1"
EOF

    # Grant execution permissions to the run tool itself
    sudo chmod +x "/usr/local/bin/newuser"
    echo "Installation complete: 'newuser' is ready to use."
else
    echo "fatal: /usr/local/bin not found"
    exit 1
fi

exit 0
