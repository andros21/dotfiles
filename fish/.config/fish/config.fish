# config.fish
# ===========

if status is-login
   # Set XDG_CONFIG_HOME
   set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME ~/.config
   # Set XDG_DATA_DIRS
   set -q XDG_DATA_DIRS; or set -x XDG_DATA_DIRS \
      ~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share/:/usr/share/
   # Change PATH
   set -x PATH "$HOME/.local/bin" $PATH
   # If RUST installed, modify PATH
   if test -d ~/.cargo/bin
      set -x PATH "$HOME/.cargo/bin" $PATH
   end
   # If FISHER not installed, install it with plugins
   if not functions -q fisher
      curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
      if test $status
         fisher install jethrokuan/z
         fisher install PatrickF1/fzf.fish@v8.1
      end
   end
   # GPG as ssh-agent
   set -q SSH_AUTH_SOCK; or set -l SSH_AUTH_SOCK null
   if test $SSH_AUTH_SOCK != (gpgconf --list-dirs agent-ssh-socket)
      type ssh-agent >/dev/null 2>&1; and ssh-agent -k 2>/dev/null
      gpgconf --launch gpg-agent
      if test $status
         set -x GPG_TTY (tty)
         set -x SSH_AGENT_PID (pgrep gpg-agent)
         set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      end
   end
   # Default EDITOR
   set -x EDITOR nvim
   # Default MANPAGER
   set -x MANPAGER 'nvim +Man!'
   # Nord theme BAT
   set -x BAT_THEME 'Nord'
   # Set my FISH color theme
   set -q fish_my_color_theme; or fish_set_my_color_theme
   # Startx for Alpine Linux (.xinitrc no gdm)
   if test (awk -F '=' '/^ID=/ {print $2}' /etc/os-release) = 'alpine'
      if test -z "$DISPLAY" -a "$XDG_VTNR"=1 -a (tty) = "/dev/tty1"
         # Tweak PATH appending
         set -ax PATH /usr/local/bin /usr/local/sbin /usr/sbin /sbin
         # Startx
         exec startx -- -keeptty
      end
   end
else
   # Default FZF command
   ## for fzf fisher plugin
   set fzf_fd_opts --hidden --follow --exclude='{.cache,.git,.venv}'
   ## for fzf nvim plugin
   set -gx FZF_DEFAULT_COMMAND "fd $fzf_fd_opts 2>/dev/null"
end
