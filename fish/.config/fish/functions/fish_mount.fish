# Udisksctl mount devices
function fish_mount -d "Udisksctl mount devs"
    if [ -d /dev/disk/by-label/ ]
        set -l label (fd . /dev/disk/by-label/ | fzf +m)
        if test -n "$label"
            echo -n "Mounting $label ... "
            udisksctl mount -b (realpath $label)
        end
    else
        set -l block (fd "(sd[a-i][1-9]|mmcblk0p[1-9])" /dev | fzf +m)
        if test -n "$block"
            echo -n "Mounting $block ... "
            udisksctl mount -b "$block"
        end
    end
end
