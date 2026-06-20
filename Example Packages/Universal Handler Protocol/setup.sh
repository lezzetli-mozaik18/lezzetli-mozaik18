#!/bin/bash
a="$(cd "$(dirname "$0")" && pwd)"
read -p "Where to setup? -> " pref
if [ -f "$a/handler.18" ]; then
if [ -d "$pref" ]; then
cp "$a/handler.18" "$pref"
mkdir "$pref/hdp18"
echo "To use the Handler protocol, please put the scripts inside the hdp18 folder that should have been created alongside handler.18."
else
printf "EC-21X-015"
fi
else
printf "EC-21X-015"
fi
exit
