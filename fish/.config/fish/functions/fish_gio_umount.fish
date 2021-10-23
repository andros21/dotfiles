# Gio umount devices
function fish_gio_umount -d "Gio umount devs"
   if [ -d "/dev/disk/by-label/" ]
      set -l label (ls "/dev/disk/by-label/" | fzf +m)
      if test -n "$label"
         echo -n "Umounting $label ... "
         gio mount -u "/run/media/"(whoami)"/$label"
         [ $status -eq 0 ] && echo "done"
      end
   else
      set -l block (fd --regex "/dev/sd[a-i][1-9]" | fzf +m)
      if test -n "$block"
         echo -n "Umounting $block ... "
         umount "/dev/$block"
         [ $status -eq 0 ] && echo "done"
      end
   end
end
