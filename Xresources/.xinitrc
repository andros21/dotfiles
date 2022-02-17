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
# Setup a static wallpaper
feh --bg-scale ~/Pictures/Wallpapers/nord.jpg
# Run in background a window composer (to render alpha effects)
picom -b
# Source Xresources
xrdb -merge ~/.Xresources
# Run pipewire
pipewire &> /dev/null &
# Run WM via dbus
dbus-launch --exit-with-session dwm
