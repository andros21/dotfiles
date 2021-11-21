# config.fish
# ===========

if status is-login
   # Set XDG_CONFIG_HOME
   set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME ~/.config
   # Change PATH
   set -x PATH "$HOME/.local/bin" $PATH
   # If FISHER not installed, install it with plugins
   if not functions -q fisher
      curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
      if test $status
         source $XDG_CONFIG_HOME/fish/functions/fisher.fish
         fisher install jorgebucaran/fisher
         fisher install jethrokuan/z
         fisher install PatrickF1/fzf.fish
      end
   end
   # If PYENV installed, source it
   # +++ Warning +++
   # Not initialized yet, if needed, init it:
   # $ pyenv init --path | source
   if [ -d "$HOME/.pyenv/" ]
      set -x PATH "$HOME/.pyenv/bin" $PATH
      pyenv init --path | source
   end
   # GPG as ssh-agent
   set -q SSH_AUTH_SOCK; or set -x SSH_AUTH_SOCK null
   if test $SSH_AUTH_SOCK != (gpgconf --list-dirs agent-ssh-socket)
      ssh-agent -k 2> /dev/null
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
   set -x MANPAGER "nvim -c 'set ft=man' -"
   # Nord theme BAT
   set -x BAT_THEME "Nord"
   # Set my FISH color theme
   set -q fish_my_color_theme; or fish_set_my_color_theme
else
   # Default FZF command
   ## for fzf fisher plugin
   set fzf_fd_opts --no-ignore --hidden --follow --exclude="{.cache,.git}"
   ## for fzf nvim plugin
   set -gx FZF_DEFAULT_COMMAND 'fd $fzf_fd_opts 2>/dev/null'
end
