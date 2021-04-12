# Gio mount devices
function fish_gio_mount -d "Gio mount devices"
   set -l label (ls "/dev/disk/by-label/" | fzf +m)
   echo -n "Mounting $label ... "
   gio mount -d (realpath /dev/disk/by-label/$label)
   echo "done"
end
