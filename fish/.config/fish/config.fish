# config.fish
# ===========

if status is-login
   # Set XDG_CONFIG_HOME
   set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME ~/.config
   # Change PATH
   set -x PATH "$HOME/.local/bin" $PATH
   # If fisher not installed, install it with plugins
   if not functions -q fisher
      curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
      if test $status
         source $XDG_CONFIG_HOME/fish/functions/fisher.fish
         fisher install jorgebucaran/fisher
         fisher install jethrokuan/z
         fisher install PatrickF1/fzf.fish
      end
   end
   # If pyenv installed, source it
   # +++ Warning +++
   # Not initialized yet, if needed, init it:
   # $ pyenv init --path | source
   if [ -d "$HOME/.pyenv/" ]
      set -x PATH "$HOME/.pyenv/bin" $PATH
      pyenv init --path | source
   end
   # GPG as ssh-agent
   if test $SSH_AUTH_SOCK != (gpgconf --list-dirs agent-ssh-socket)
      ssh-agent -k
      gpgconf --launch gpg-agent
      if test $status
         set -x GPG_TTY /dev/pts/0
         set -x SSH_AGENT_PID (pgrep gpg-agent)
         set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      end
   end
   # Default EDITOR
   set -x EDITOR nvim
   # Default MANPAGER
   set -x MANPAGER "nvim -c 'set ft=man' -"
   # Nord theme bat
   set -x BAT_THEME "Nord"
else
   # Default FZF command
   # for fzf fisher plugin
   set fzf_fd_opts --no-ignore --hidden --follow --exclude="{.cache,.git}"
   # for fzf nvim plugin
   set -x FZF_DEFAULT_COMMAND 'fd $fzf_fd_opts 2>/dev/null'
end

# Fish color scheme
set -U fish_color_autosuggestion 969896
set -U fish_color_cancel \x2dr
set -U fish_color_command c397d8
set -U fish_color_comment e7c547
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end c397d8
set -U fish_color_error d54e53
set -U fish_color_escape 00a6b2
set -U fish_color_history_current \x2d\x2dbold
set -U fish_color_host normal
set -U fish_color_host_remote yellow
set -U fish_color_match \x2d\x2dbackground\x3dbrblue
set -U fish_color_normal normal
set -U fish_color_operator 00a6b2
set -U fish_color_param 7aa6da
set -U fish_color_quote b9ca4a
set -U fish_color_redirection 70c0b1
set -U fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set -U fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path \x2d\x2dunderline
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D\x1eyellow
set -U fish_pager_color_prefix white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set -U fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
