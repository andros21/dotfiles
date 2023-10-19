<!-- PROJECT LOGO -->
<br>
<div align="center">
  <a href="https://github.com/andros21/dotfiles">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/58751603/169137703-717ae1ef-3b2e-482b-a70b-377e38f9ee35.png">
      <img src="https://user-images.githubusercontent.com/58751603/126770241-9aa8d18c-bd06-433c-b542-1ab9f66a3495.png" alt="Logo" width="470">
    </picture>
  </a>
  <br>
  <br>
  <a href="https://github.com/andros21/dotfiles/blob/master/.github/workflows/lint.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/andros21/dotfiles/lint.yml?branch=master&label=Lint%20CI&logo=github&style=flat-square" alt="Lint CI"></a>
  <a href="https://dwm.suckless.org/">
   <img src="https://img.shields.io/badge/dwm-powered-important?logo=fedora&style=flat-square" alt="Lint CI"></a>
  <a href="https://dwm.suckless.org/">
   <img src="https://img.shields.io/badge/dwm-powered-important?logo=alpinelinux&style=flat-square" alt="Lint CI"></a>
  <a href="https://github.com/andros21/dotfiles/blob/master/LICENSE">
    <img src="https://img.shields.io/github/license/andros21/dotfiles?color=blue&label=License&style=flat-square" alt="License"></a>

  <h3 align="center">with ansible playbooks</h3>
  <div align="center">
    The aim of this repo is in progress,<br>cause my dotfiles are in progress too &#128521
    <br>
    <br>
    <a href="ansible/.ansible/dwm/">Ansible</a>
    ·
    <a href="#star-features">Features</a>
    ·
    <a href="#rocket-usage">Usage</a>
  </div>
</div>

## :star: Features

#### X server `Xorg`

- Nord color style, thanks to [Nord Xresources](https://github.com/arcticicestudio/nord-xresources)
- On `fedora`:
  - Custom Xsession starting **dwm** as WM on Xorg
  - `Xresources/.profile` sourced (by `xinitrc-common`) to prepare X env, before WM start
- On `alpine`:
  - Custom `.xinitrc` for starting **dwm** with `startx`

#### Window manager `dwm`

Custom [Luke's build of dwm](https://github.com/LukeSmithxyz/dwm), here my build [dwm](https://github.com/andros21/dwm)

- Xresources color/style setup

#### Terminal `alacritty`

- Very similar st style, nord theme colors too

#### Terminal multiplexer `tmux`

- [Nord theme status](https://github.com/arcticicestudio/nord-tmux) bar and theme
- [Tmux-config](https://github.com/samoshkin/tmux-config)
  - Vi key bindings
  - Clipboard integration
  - Nested tmux session handling (local+remote)
- [Tpm](https://github.com/tmux-plugins/tpm) as default plugin manager

#### Shell `fish`

- [starship](https://starship.rs/) cross-shell prompt
- [zoxide](https://github.com/ajeetdsouza/zoxide) smarter cd command
- Switch from ssh-agent to gpg-agent for ssh-key authentication
- Speed up shell loading, dividing `login` tasks, from `no-login` tasks
- [Fisher](https://github.com/jorgebucaran/fisher) as default plugin manager
- [fzf.fish](https://github.com/PatrickF1/fzf.fish) fzf fisher plugin
- Custom aliases and functions for fish, aesthetics and functional purpose
- [Nord dir colors](https://github.com/arcticicestudio/nord-dircolors)
- udisksctl mount simple functions and relative aliases

#### Status bar `dwmblocks`

Custom [Luke's build of dwmblocks](https://github.com/LukeSmithxyz/dwmblocks), here my build [dwmblocks](https://github.com/andros21/dwmblocks)

`dwmstatusbar` contain the scripts needed by dwmblocks to work, all the available [here](https://github.com/LukeSmithxyz/voidrice/tree/master/.local/bin/statusbar)

- Xresources color/style setup

#### Screen locker `slock`

Here my build [slock](https://github.com/andros21/slock)

- Xresources color/style setup

#### Launcher `rofi`

- Custom theme `nord.rasi`

#### Editor `neovim`

- [lazy.nvim](https://github.com/folke/lazy.nvim) as default plugin manager
- [mason.nvim](https://github.com/williamboman/mason.nvim) as tool providers
- [lualine](https://github.com/nvim-lualine/lualine.nvim) with [nord-theme](https://github.com/arcticicestudio/nord-vim) plugin
- [bufferline](https://github.com/akinsho/bufferline.nvim) buffers as tabs and more
- [formatter.nvim](https://github.com/mhartington/formatter.nvim) format on save (bins automatically provisioned by [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim))
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) async lint with built-in lsp support (bins automatically provisioned by [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim))
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) easily moving around (files, tabs, lines, stages, ripgrep, ...)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlight and more
- [LazyVim](https://github.com/LazyVim/LazyVim) autocmds, options, keymaps, devicons
- aesthetics and essential plugins for file editing e.g. [mini](https://github.com/echasnovski/mini.nvim)

#### File Manager `ranger`

- custom `rc.conf`
- custom `commands.py`:
  - [zoxide](https://github.com/jchook/ranger-zoxide)
  - [devicons](https://github.com/alexanderjeurissen/ranger_devicons)
  - fzf search
  - compress/extract with [atool](https://www.nongnu.org/atool/)

#### Miscellanea

- [rofi-pass](https://github.com/carnager/rofi-pass) as GNU/pass frontend
- [rofi-power](https://github.com/okraits/rofi-tools) as systemctl power tool
- [teiler](https://github.com/carnager/teiler) as powerful screenshots and screencasts tool
- [ytdl-mpv](https://github.com/andros21/ytdl-mpv) as yt player
- [distrobox](https://github.com/89luca89/distrobox) as podman wrapper

## :rocket: Usage

### Prerequisites

- `fedora == 37`
  - a sudo user
  - `requirements.txt`
  - `requirements-dev.txt` (devel)
- `alpine == 3.18`
  - a sudo user
  - advice `apk add py3-pip py3-cryptography`
  - `requirements.txt`
  - `requirements-dev.txt` (devel)

### How to run

It's simple:

- Pull the repository
- Read/check with attention the ansible `dwm` playbook
- Run it

  ```bash
  git clone https://github.com/andros21/dotfiles.git ~/.dotfiles
  cd ~/.dotfiles/ansible/.ansible/dwm/
  ansible-galaxy collection install -r requirements.yml
  ansible-playbook dwm.yml
  sudo reboot
  ```
