# Gio mount devices
function fish_gio_mount -d "Gio mount devs"
   if [ -d "/dev/disk/by-label/" ]
      set -l label (ls "/dev/disk/by-label/" | fzf +m)
      if test -n "$label"
         echo -n "Mounting $label ... "
         gio mount -d (realpath /dev/disk/by-label/$label)
         [ $status -eq 0 ] && echo "done"
      end
   else
      set -l block (fd --regex "/dev/sd[a-i][1-9]" | fzf +m)
      if test -n "$block"
         echo -n "Mounting $block ... "
         gio mount -d "/dev/$block"
         [ $status -eq 0 ] && echo "done"
      end
   end
end
