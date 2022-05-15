# alpine
# ======
# Sourced by startx
# setting up my X env and start WM
# --------------------------------

# Setup minor screen resolution for built-in screen
xrandr --output eDP-1 --mode 1368x768
# Setup higher keyboard rate
xset r rate 300 35
# Setup keyboard language
setxkbmap it
# Xinput set touchpad properties
xinput set-prop "AlpsPS/2 ALPS GlidePoint" "libinput Tapping Enabled" 1
xinput set-prop "AlpsPS/2 ALPS GlidePoint" "libinput Natural Scrolling Enabled" 1
xinput set-prop "AlpsPS/2 ALPS GlidePoint" "libinput Accel Speed" 0.3
# Disable beep
xset -b
# GPG as ssh-agent
ssh-agent -k 2>/dev/null
gpgconf --launch gpg-agent
if [ $? -eq 0 ]; then
   export GPG_TTY=$(tty)
   export SSH_AGENT_PID=$(pgrep gpg-agent)
   export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
# Setup a random wallpaper
feh --bg-scale --randomize ~/Pictures/Wallpapers/*
# Run in background a window composer (to render alpha effects)
picom -b
# Source Xresources
xrdb -merge ~/.Xresources
# Run xautolocker
xautolock -time 5 -locker slock -nowlocker slock -corners 000- &
# Run pipewire
pipewire &> /dev/null &
# Run WM via dbus
dbus-launch --exit-with-session dwm
