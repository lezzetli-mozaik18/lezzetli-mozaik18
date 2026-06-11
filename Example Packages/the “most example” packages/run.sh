#!/bin/bash

echo "run.sh"
read -p "This is a tool that replaces 'chmod +x' with 'run', as chmod is frequently used to give execution permissions. Please press enter to continue installing or CTR
+C to terminate the process." null
if [ -d "/usr/local/bin" ]; then
sudo touch "/usr/local/bin/run"
echo 'chmod +x "$1"' | sudo tee "/usr/local/bin/run" > /dev/null
else
echo "fatal: /usr/local/bin not found"
fi
exit 0
