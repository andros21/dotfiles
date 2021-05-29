# dotfiles :gear:

## :blue_book: Description

Create this repo to backup and at the same time share my configuration files. The aim of this repo is in progress, cause my dotfiles are in progress too.

## :star: Features

### Fedora dwm <img src="https://icons.iconarchive.com/icons/papirus-team/papirus-apps/32/distributor-logo-fedora-icon.png" alt="drawing" width="26" Hspace="7" style="margin-bottom:-3px;">

#### X server | `Xorg`

* Nord color style, thanks to [Nord Xresources](https://github.com/arcticicestudio/nord-xresources)
* Custom touchpad movement using `libinput` driver
* Custom Xsession starting **dwm** as WM on Xorg
* `Xresources/.profile` sourced (by `xinitrc-common` on Fedora) to prepare X env, before WM start

#### Window manager | `dwm`

Custom [Luke's build of dwm](https://github.com/LukeSmithxyz/dwm), here my build [dwm-luke](https://github.com/andros21/dwm-luke)

* Xresources color/style setup

#### Terminal | `alacritty`

* Very similar st style, nord theme colors too

#### Terminal multiplexer | `tmux`

* [Nord theme status](https://github.com/arcticicestudio/nord-tmux) bar and theme
* [Tmux-config](https://github.com/samoshkin/tmux-config)
   * Vi key bindings
   * Clipboard integration
   * Nested tmux session handling (local+remote)
* [Tpm](https://github.com/tmux-plugins/tpm) as default plugin manager

#### Shell | `fish`

* Minimal custom fish shell prompt with git symbol integration (see [here](https://github.com/magicmonty/bash-git-prompt))
* Switch from ssh-agent to gpg-agent for ssh-key authentication
* [Fisher](https://github.com/jorgebucaran/fisher) as default plugin manager
* Custom aliases and functions for fish, aesthetics and functional purpose
* [Nord dir colors](https://github.com/arcticicestudio/nord-dircolors)
* Gio mount/umount simple functions and relative aliases

#### Status bar | `dwmblocks`

Custom [Luke's build of dwmblocks](https://github.com/LukeSmithxyz/dwmblocks), here my build [dwmblocks-luke](https://github.com/andros21/dwmblocks-luke)

`dwmstatusbar` contain the scripts needed by dwmblocks to work, with some little personal changes and not all the available [here](https://github.com/LukeSmithxyz/voidrice/tree/master/.local/bin/statusbar)

* Xresources color/style setup

#### Screen locker | `slock`

Here my build [slock](https://github.com/andros21/slock)

* Xresources color/style setup

#### Launcher | `rofi`

* Xresources color/style setup
* Custom default theme `my-default.rasi`, avoiding lines count and "Type to filter" after prompt

#### Editor | `neovim`

* [vim-plug](https://github.com/junegunn/vim-plug) as default plugin manager
* aesthetics and essential plugins for file editing
* buffers as tabs
* autocmd for resume cursor position
* `pynvim` module available inside pyenv virtualenv
* [deoplete](https://github.com/Shougo/deoplete.nvim) as auto-completer
* [ALE](https://github.com/dense-analysis/ale) as linter and fixer (bins inside pyenv virtualenv)
* [mirror.vim](https://github.com/zenbro/mirror.vim) as advance remote file editor plugin
* personal mappings

#### File Manager | `ranger`

* custom `rc.conf` (gio utilities)
* custom `commands.py`:
   + z jump (using fish z database)
   + devicons
   + fzf search
   + compress/extract with [atool](https://www.nongnu.org/atool/)

#### Miscellanea

* [rofi-pass](https://github.com/carnager/rofi-pass) as GNU/pass frontend
* [rofi-power](https://github.com/okraits/rofi-tools) as systemctl power tool
* [teiler](https://github.com/carnager/teiler) as powerful screenshots and screencasts tool
* [ytdl-mpv](https://github.com/andros21/ytdl-mpv) as yt player

## :rocket: Usage

It's simple:

* Pull the repository
* Read/check with attention the ansible `dwm` playbook
* Run it

```bash
$ git clone https://github.com/andros21/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles/ansible/.ansible/dwm/
$ ansible-galaxy collection install -r
$ ansible-playbook dwm.yml
$ sudo reboot
```
