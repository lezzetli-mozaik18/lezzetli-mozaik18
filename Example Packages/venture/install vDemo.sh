#!/bin/bash

echo "install vDemo.sh"
echo
echo "  venture Demo"
echo "You may be asked for admin privileges."
groups | grep -e "sudo"
if [ -d "/usr/local/bin" ]; then
sudo touch "/usr/local/bin/venture"
sudo cat << 'EOF' > "/usr/local/bin/venture"
#!/bin/bash

loop() {
cd "$current"
ls
echo
read -p "Select: " selection
case "$selection" in
*)
cd "$current$selection"
loop
;;
^help)
echo "^back OR ^b | ^nano | ^exit"
loop
;;
^b|^back)
{please write this part of the script to go to parent dir}
;;
^nano)
read -p "Edit: " nano
nano "$current$nano"
loop
;;
^exit)
exit 0
;;
esac
}

if [ -z "$1" ]; then
current=$(echo "/")
loop
else
current=$(echo "$1")
loop
fi

EOF

sudo chmod +x "/usr/local/bin/venture"
echo done
exit 0
