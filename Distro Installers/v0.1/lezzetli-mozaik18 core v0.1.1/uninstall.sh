#!/bin/bash

echo
echo "Welcome to the uninstaller."
echo "Warning: this process will remove all data beyond the directory '/opt/lezzetli-mozaik18' and the shell script '/usr/local/bin/lezzetli-mozaik18'."
read -p "Please proceed with consent. Uninstall / Cancel -> " pref
case "$pref" in
	Uninstall)
	echo "sudo rm -r /opt/lezzetli-mozaik18/*"
	sudo rm -r /opt/lezzetli-mozaik18/*
	echo "sudo rm -r /opt/lezzetli-mozaik18"
	sudo rm -r /opt/lezzetli-mozaik18
	echo "sudo rm -r /usr/local/bin/lezzetli-mozaik18"
	sudo rm -r /usr/local/bin/lezzetli-mozaik18
	;;
	Cancel)
	echo
	echo "Exiting..."
	sleep 1
	exit 0
	;;
esac
