# fedora
# ======
# Sourced by xinitrc-common
# setting up my X env, before WM start
# ------------------------------------

if [ "$GDMSESSION" = "dwm-xorg" ]; then
   # Monitor setup as function of connected monitors
   #  1. Reduce built-in screen resolution
   #  2. Mirrors with auto resolution
   mapfile -t MONITORS < <(xrandr | awk '$2 == "connected" {print $1}')
   NUM_MONITORS=${#MONITORS[@]}
   if [[ $NUM_MONITORS -eq 1 ]]; then
      xrandr --output "${MONITORS[0]}" --mode 1368x768
   elif [[ $NUM_MONITORS -eq 2 ]]; then
      xrandr --output "${MONITORS[0]}" --auto --output "${MONITORS[1]}" --auto --same-as "${MONITORS[0]}"
   else
      xrandr --auto
   fi
   # Setup higher keyboard rate
   xset r rate 300 35
   # Xinput set touchpad properties
   xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
   xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
   xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Accel Speed" 0.3
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
   # Run xautolocker
   xautolock -time 5 -locker slock -nowlocker slock -corners 000- &
fi
