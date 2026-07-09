#!/usr/bin/env bash



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

gui() {

# BashDesk (Refactored Skeleton)
#

FPS=60
FRAME_TIME=0.016666

COLS=80
ROWS=24
DIRTY=1

SELECTED=0
STATUS="Ready."

########################################
# Desktop Database
########################################

ITEM_ICON=()
ITEM_NAME=()
ITEM_ROW=()
ITEM_COL=()
ITEM_APP=()

add_item() {
    ITEM_ICON+=("$1")
    ITEM_NAME+=("$2")
    ITEM_ROW+=("$3")
    ITEM_COL+=("$4")
    ITEM_APP+=("$5")
}

item_count() {
    echo "${#ITEM_NAME[@]}"
}

########################################
# Applications
########################################

files_app(){ STATUS="Opened Files"; }
notes_app(){ STATUS="Opened Notes"; }
settings_app(){ STATUS="Opened Settings"; }
terminal_app(){ STATUS="Opened Terminal"; }

launch_item() {
    local app="${ITEM_APP[$SELECTED]}"
    if declare -F "$app" >/dev/null; then
        "$app"
    else
        STATUS="No handler: $app"
    fi
}

########################################
# Configure desktop
########################################

add_item "📁" "Files"      3 6 files_app
add_item "📄" "Notes"      5 6 notes_app
add_item "⚙" "Settings"   7 6 settings_app
add_item "🖥" "Terminal"   9 6 terminal_app

########################################
# Terminal
########################################

cleanup(){
    printf '\033[?25h\033[0m\033[2J\033[H'
    stty sane
    exit
}
trap cleanup EXIT INT TERM

resize(){
    COLS=$(tput cols)
    ROWS=$(tput lines)
    ((COLS<80))&&COLS=80
    ((ROWS<24))&&ROWS=24
    DIRTY=1
}
trap resize WINCH

init(){
    stty -echo -icanon time 0 min 0
    printf '\033[?25l'
    resize
}

########################################
# Graphics
########################################

goto_xy(){ printf '\033[%d;%dH' "$(($1+1))" "$(($2+1))"; }
fg(){ printf '\033[3%sm' "$1"; }
bg(){ printf '\033[4%sm' "$1"; }
reset(){ printf '\033[0m'; }

fill_line(){
    goto_xy "$1" 0
    for((x=0;x<COLS;x++));do printf " ";done
}

fill_rect(){
    for((y=$1;y<=$3;y++));do
        goto_xy "$y" "$2"
        for((x=$2;x<=$4;x++));do printf " ";done
    done
}

text(){
    goto_xy "$1" "$2"
    printf "%s" "$3"
}

draw_item(){
    local i=$1
    if ((i==SELECTED));then
        bg 7; fg 0
    else
        bg 0; fg 7
    fi
    text "${ITEM_ROW[i]}" "${ITEM_COL[i]}" "${ITEM_ICON[i]} ${ITEM_NAME[i]}"
}

draw_desktop(){
    bg 0; fg 7
    fill_rect 1 0 $((ROWS-2)) $((COLS-1))
    local count=$(item_count)
    for((i=0;i<count;i++));do
        draw_item "$i"
    done
}

draw(){
    printf '\033[H'
    bg 4; fg 7
    fill_line 0
    text 0 2 "BashDesk"
    text 0 $((COLS-9)) "$(date +%H:%M:%S)"
    draw_desktop
    reset
    bg 7; fg 0
    fill_line $((ROWS-1))
    text $((ROWS-1)) 2 "$STATUS"
    reset
}

########################################
# Input
########################################

read_input(){
    local key count
    IFS= read -rsn1 key || return
    case "$key" in
        $'\e')
            IFS= read -rsn2 key
            case "$key" in
                "[A"|"[D") ((SELECTED--));;
                "[B"|"[C") ((SELECTED++));;
                "") cleanup;;
            esac;;
        "") launch_item;;
        [WwAa]) ((SELECTED--));;
        [SsDd]|$'\t') ((SELECTED++));;
        [Qq]) cleanup;;
    esac
    count=$(item_count)
    ((SELECTED<0))&&SELECTED=$((count-1))
    ((SELECTED>=count))&&SELECTED=0
    DIRTY=1
}

########################################
# Main
########################################

init
while true;do
    read_input
    if ((DIRTY));then
        draw
        DIRTY=0
    fi
    sleep "$FRAME_TIME"
done
}

case "$1" in
	
	-d)
		if [ -z "$2" ]; then
		printf '%s\n' \ "Usage: apm -d <primary_flag> <secondary_flag> <...> (needs piped data)"
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
	
	-g)
	
		gui
		
	;;
	
	*)
	
		printf '%s\n' "Usage: apm <applet> <...>"
		exit 0
	
esac
