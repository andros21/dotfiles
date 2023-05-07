# Umount devices
function fish_umount -d "Umount devs"
   if [ -d "/dev/disk/by-label/" ]
      set -l label (ls "/dev/disk/by-label/" | fzf +m)
      if test -n "$label"
         echo -n "Umounting $label ... "
         udisksctl unmount -b (realpath /dev/disk/by-label/$label)
      end
   else
      set -l block (fd "(sd[a-i][1-9]|mmcblk0p[1-9])" /dev | fzf +m)
      if test -n "$block"
         echo -n "Umounting $block ... "
         udisksctl unmount -b "$block"
      end
   end
end
