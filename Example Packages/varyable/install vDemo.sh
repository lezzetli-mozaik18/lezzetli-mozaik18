#!/bin/bash

echo "install.sh"
echo
echo "  varyable Demo"
groups | grep -e "sudo"
echo 
echo 'sudo mkdir "/opt/varyable"'
sudo mkdir "/opt/varyable"
echo 'sudo touch "/usr/local/bin/varyable"'
sudo touch "/usr/local/bin/varyable"
sudo cat << 'EOF' > /usr/local/bin/varyable
#!/bin/bash

case "$1" in

-new) 
if [ -f "/opt/varyable/$2" ]; then 
echo "fatal: already exists"
else
sudo touch "/opt/varyable/$2"
fi
;;

-del)
if [ -f "/opt/varyable/$2" ]; then
sudo rm -f "/opt/varyable/$2"
else
echo "fatal: not found"
fi
;;

-set)
if [ -f "/opt/varyable/$2" ]; then
read -p "set $2 to: " sval
echo "$sval" | sudo tee "/opt/varyable/$2" > /dev/null
else
echo "fatal: not found"
fi
;;

-ls)
ls /opt/varyable
;;

-get)
if [ -f "/opt/varyable/$2" ]; then
sudo cat "/opt/varyable/$2"
else
echo "fatal: not found"
fi
;;

*)
echo
echo "-new"
echo "-del"
echo "-ls"
echo "-set"
echo "-get"
echo
;;
esac
EOF
echo "made varyable"
sudo chmod +x "/usr/local/bin/varyable"
echo "made executable"
echo "done"

exit 0
