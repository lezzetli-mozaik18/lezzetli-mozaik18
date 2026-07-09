#!/bin/bash

case "$1" in

	"-s")

		# string
		printf '%s\n' "  $(cat)"

	;;

	"-M")

		# menu start
		printf '%s\n' "  « $(cat) »"
		printf '%s\n' "  ----------"

	;;

	"-m")
		# menu item
		printf '%s\n' "  ~> $(cat) "

	;;

	"-n")
		# newline
		printf '\n'

	;;

	"-c")
		# clear
		clear

	;;

	"-C")
		# compose
		clear
		printf '%s'

	;;

	"-W")
		# warning start (the rest can be displayed via "-s".)
		printf '%s\n' "  <~ %%%%%%%%%%%% ~>"
		printf '\e[31m%s\e[0m\n' "  $(cat)"
		printf '%s\n' "  <~ %%%%%%%%%%%% ~>"

	;;

	*)

		# error
		printf "lm18-bash-dispmgr: error"

	;;

esac
