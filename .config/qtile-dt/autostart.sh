#!/usr/bin/env bash 

COLORSCHEME="DoomOne"

festival --tts $HOME/.config/qtile/welcome_msg &
lxsession &
picom &
/usr/bin/emacs --daemon &
killall conky &
sleep 3 && conky -c "$HOME"/.config/conky/qtile/"$COLORSCHEME"-01.conkyrc
killall volumeicon &
volumeicon &
nm-applet &

### UNCOMMENT ONLY ONE OF THE FOLLOWING THREE OPTIONS! ###
# 1. Uncomment to restore last saved wallpaper
xargs xwallpaper --stretch < ~/.cache/wall &
# 2. Uncomment to set a random wallpaper on login
# find /usr/share/backgrounds/dtos-backgrounds/ -type f | shuf -n 1 | xargs xwallpaper --stretch &
# 3. Uncomment to set wallpaper with nitrogen
# nitrogen --restore &
