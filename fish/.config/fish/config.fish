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
    # If python venvs installed, modify PATH
    if test -d ~/.local/share/venv
        set -l PYV py3(python3 --version | awk -F '.' '{print $2}')
        set -x PATH "$HOME/.local/share/venv/$PYV/local/bin" $PATH
        set -x PATH "$HOME/.local/share/venv/$PYV/ansible/bin" $PATH
    end
    # If FISHER not installed, install it with plugins
    if not functions -q fisher
        set -l FISHER_SHA 2efd33ccd0777ece3f58895a093f32932bd377b6 # tag: 4.4.4
        set -l FZF_SHA 8920367cf85eee5218cc25a11e209d46e2591e7a # tag: v10.3
        curl -sSL https://raw.githubusercontent.com/jorgebucaran/fisher/$FISHER_SHA/functions/fisher.fish \
            | source && fisher install jorgebucaran/fisher@$FISHER_SHA
        if test $status
            fisher install PatrickF1/fzf.fish@$FZF_SHA
        end
    end
    # If STARSHIP not installed, install it
    if not functions -q starship
        curl -sSL https://starship.rs/install.sh \
            | sh -s -- -y -v v1.21.1 -b $HOME/.local/bin >/dev/null
    end
    # Default EDITOR
    set -x EDITOR nvim
    # Default MANPAGER
    set -x MANPAGER 'nvim +Man!'
    # Nord theme BAT
    set -x BAT_THEME Nord
    # Startx for Alpine Linux (.xinitrc no gdm)
    if test (awk -F '=' '/^ID=/ {print $2}' /etc/os-release) = alpine
        # Tweak PATH appending
        set -ax PATH /usr/local/bin /usr/local/sbin /usr/sbin /sbin
        if test -z "$DISPLAY" -a "$XDG_VTNR"=1 -a (tty) = /dev/tty1
            # Startx
            exec startx -- -keeptty
        end
    end
else
    # Default FZF command
    ## for fzf fisher plugin
    set fzf_fd_opts --hidden --follow --exclude='{.cache,.git,.venv}'
    set fzf_diff_highlighter (which delta)
    ## for fzf inside ranger
    set -gx FZF_DEFAULT_COMMAND "fd $fzf_fd_opts 2>/dev/null"
    # Starship fire on
    starship init fish | source
    # Zoxide fire on
    zoxide init fish | source
end
