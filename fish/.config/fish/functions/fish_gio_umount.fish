# Gio umount devices
function fish_gio_umount -d "Gio mount devices"
   set -l label (ls "/dev/disk/by-label/" | fzf +m)
   echo -n "Umounting $label ... "
   gio mount -u "/run/media/"(whoami)"/$label"
   echo "done"
end
