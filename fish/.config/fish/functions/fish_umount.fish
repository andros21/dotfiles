# Umount devices
function fish_umount -d "Umount devs"
   if [ -d "/dev/disk/by-label/" ]
      set -l label (ls "/dev/disk/by-label/" | fzf +m)
      if test -n "$label"
         echo -n "Umounting $label ... "
         umount "/run/media/"(whoami)"/$label" && echo "done"
      end
   else
      set -l block (fd --regex "/dev/sd[a-i][1-9]" | fzf +m)
      if test -n "$block"
         echo -n "Umounting $block ... "
         umount "/dev/$block" && echo "done"
      end
   end
end
