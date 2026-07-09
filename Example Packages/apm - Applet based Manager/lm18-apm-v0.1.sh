#!/bin/bash



dpmg() {
# ======================================================
# Hybrid Display Manager (HDM)
# ======================================================

# Colors
c_reset="\e[0m"

c_red="\e[31m"
c_green="\e[32m"
c_blue="\e[34m"
c_yellow="\e[33m"
c_cyan="\e[36m"

# ------------------------------------------------------
# Stream printer (real-time)
# ------------------------------------------------------
stream() {
    while IFS= read -r line || [[ -n $line ]]; do
        printf '~> %s\n' "$line"
    done
}

# ------------------------------------------------------
# Center a block of text on the screen.
# Reads stdin, buffers it, then prints it centered.
# ------------------------------------------------------
center_block() {

    mapfile -t lines

    rows=$(tput lines)
    cols=$(tput cols)

    count=${#lines[@]}

    start_row=$(( (rows - count) / 2 ))
    (( start_row < 0 )) && start_row=0

    for ((i=0;i<count;i++)); do

        line="${lines[i]}"

        # Remove ANSI escapes when calculating width
        plain=$(printf "%s" "$line" | sed -E 's/\x1B\[[0-9;]*[A-Za-z]//g')

        width=${#plain}

        pad=$(( (cols - width) / 2 ))
        (( pad < 0 )) && pad=0

        tput cup $((start_row+i)) "$pad"
        printf "%b" "$line"
    done

    tput cup "$rows" 0
}

case "$1" in

    # --------------------------------------------------
    # Default
    # --------------------------------------------------

    -d)
        cat | center_block
        ;;

    # --------------------------------------------------
    # Raw
    # --------------------------------------------------

    -r)
        cat
        ;;

    # --------------------------------------------------
    # Stream
    # --------------------------------------------------

    -s)
        stream
        ;;

    # --------------------------------------------------
    # Menu start
    # --------------------------------------------------

    -M)
    {
        input=$(cat)
        printf "%b%s%b\n" \
            "$c_blue" \
            "$input" \
            "$c_reset"

        printf "<-------->\n"

    } | center_block
    ;;

    # --------------------------------------------------
    # Menu item
    # --------------------------------------------------

    -m)
    {
        input=$(cat)

        printf "%b~>%b %s\n" \
            "$c_green" \
            "$c_reset" \
            "$input"

    } | center_block
    ;;
    
    # --------------------------------------------------
    # Warning
    # --------------------------------------------------

    -W)
    {
        input=$(cat)

        printf "%%%%%%%%\n"

        printf "%b%s%b\n" \
            "$c_red" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Web address
    # --------------------------------------------------

    -w)
    {
        input=$(cat)

        printf "%b%s%b\n" \
            "$c_blue" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Divider
    # --------------------------------------------------

    -D)
    {
        printf "%b<%b%b--------%b%b>%b\n" \
            "$c_green" "$c_reset" \
            "$c_yellow" "$c_reset" \
            "$c_green" "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Notification
    # --------------------------------------------------

    -N)
    {
        input=$(cat)

        printf "%b%s%b\n" \
            "$c_yellow" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Notice
    # --------------------------------------------------

    -n)
    {
        input=$(cat)

        printf " !\n"
        printf "%s\n" "$input"

    } | center_block
    ;;

    # --------------------------------------------------
    # Prompt
    # --------------------------------------------------

    -P)
    {
        input=$(cat)

        printf "%b%s%b ~> " \
            "$c_yellow" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Process
    # --------------------------------------------------

    -p)
    {
        input=$(cat)

        printf " %b[%b %b%s%b %b]%b\n" \
            "$c_red" "$c_reset" \
            "$c_green" "$input" "$c_reset" \
            "$c_red" "$c_reset"

    } | center_block
    ;;
    
    # --------------------------------------------------
    # Log
    # --------------------------------------------------

    -L)
    {
        input=$(cat)

        printf "[ %s ] %s\n" "$2" "$input"

    } | center_block
    ;;

    # --------------------------------------------------
    # Red
    # --------------------------------------------------

    -1)
    {
        input=$(cat)

        printf "%b%s%b\n" \
            "$c_red" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Blue
    # --------------------------------------------------

    -2)
    {
        input=$(cat)

        printf "%b%s%b\n" \
            "$c_blue" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Green
    # --------------------------------------------------

    -3)
    {
        input=$(cat)

        printf "%b%s%b\n" \
            "$c_green" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Yellow
    # --------------------------------------------------

    -4)
    {
        input=$(cat)

        printf "%b%s%b\n" \
            "$c_yellow" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;

    # --------------------------------------------------
    # Cyan
    # --------------------------------------------------

    -5)
    {
        input=$(cat)

        printf "%b%s%b\n" \
            "$c_cyan" \
            "$input" \
            "$c_reset"

    } | center_block
    ;;
    
    # --------------------------------------------------
    # Unknown option
    # --------------------------------------------------

    *)
    {
        printf "%berr:%b unknown option\n" \
            "$c_red" \
            "$c_reset"

    } | center_block
    ;;

esac
}

parsecmap() {
DELIMITER="\%dlmt**%//"

stream_cmap_line() {
    local input_line="$1"
    local working_string="$input_line"
    local token=""

    while [[ -n "$working_string" ]]; do

        # skip leading delimiters
        if [[ "$working_string" == "$DELIMITER"* ]]; then
            working_string="${working_string#"$DELIMITER"}"
            continue
        fi

        # extract next token
        if [[ "$working_string" == *"$DELIMITER"* ]]; then
            token="${working_string%%"$DELIMITER"*}"
            working_string="${working_string#*"$DELIMITER"}"
        else
            token="$working_string"
            working_string=""
        fi

        # STREAM OUTPUT IMMEDIATELY
        [[ -n "$token" ]] && printf "%s\n" "$token"

    done
}

stream_cmap_file() {
    local file_path="$1"
    local line=""

    if [[ ! -f "$file_path" ]]; then
        echo "Error: File not found: $file_path" >&2
        return 1
    fi

    while IFS= read -r line || [[ -n "$line" ]]; do

        # skip empty/comment lines
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

        stream_cmap_line "$line"

    done < "$file_path"
}

# ENTRY POINT
if [[ -z "$1" ]]; then
    echo "Usage: $0 <file.cmap>" >&2
    exit 1
fi

stream_cmap_file "$1"
}

case "$1" in
	
	-d)
		if [ -z "$2" ]; then
		printf '%s\n' \ "Usage: apm -d <primary_flag> <secondary_flag> <...>"
		exit 0
		else
		printf ""
		fi
		dpmg "$2" "$3"
		
	;;
	
	-p)
		if [ -z "$2" ]; then
		printf '%s\n' "Usage: apm -p <file>"
		exit 0
		else
		printf ""
		fi
		parsecmap "$2"
	;;
	
	*)
	
		printf '%s\n' "Usage: apm <applet> <...>"
		exit 0
	
esac
