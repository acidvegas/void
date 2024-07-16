#!/bin/sh
# .xinitrc - developed by acidvegas (https://git.acid.vegas/void)

xset +fp /usr/share/fonts/local
xset fp rehash

dunst &
unclutter &
$HOME/.scripts/statusbar.sh &

# Example of dual monitor setup
#{ sleep 2; xrandr --output HDMI1 --mode 1920x1080 --output DP1 --mode 1920x1080 --above HDMI1; } &

# Example rotation
#{ sleep 2; xrandr --output DSI-1 --rotate right; } &

redshift -P -O 4000 & # How do we get this working on DSI-1 with the uConsole ?

exec dwm
