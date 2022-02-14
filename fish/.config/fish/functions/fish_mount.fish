# Udisksctl mount devices
function fish_mount -d "Udisksctl mount devs"
   if [ -d "/dev/disk/by-label/" ]
      set -l label (ls "/dev/disk/by-label/" | fzf +m)
      if test -n "$label"
         echo -n "Mounting $label ... "
         udisksctl mount -b (realpath /dev/disk/by-label/$label)
      end
   else
      set -l block (fd --regex "/dev/sd[a-i][1-9]" | fzf +m)
      if test -n "$block"
         echo -n "Mounting $block ... "
         udisksctl mount -b "/dev/$block"
      end
   end
end
