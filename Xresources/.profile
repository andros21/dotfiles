# fedora
# ======
# Sourced by xinitrc-common
# setting up my X env, before WM start
# ------------------------------------

if [ "$GDMSESSION" = "dwm-xorg" ]; then
   # Setup minor screen resolution for built-in screen
   xrandr --output eDP-1 --mode 1368x768
   # Setup higher keyboard rate
   xset r rate 300 35
   # Xinput set touchpad properties
   xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
   xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
   xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 0.3
   # Setup a static wallpaper
   feh --bg-scale ~/Pictures/Wallpapers/nord.jpg
   # Run in background a window composer (to render alpha effects)
   picom -b
fi
