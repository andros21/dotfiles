# aliases.fish
# ============

# path
# ----
alias l    'll'
alias rm   'rm -i'
alias md   'mkdir -p'
alias p    'cd -'
alias ..   'cd ..'
alias ...  'cd ../..'
alias cdi  'cd /run/media/rox/'
alias cdv  'cd /run/user/1000/gvfs/'

# bin
# ---
alias gpg  'gpg2'
alias nv   'nvim'
alias less 'bat'
alias cat  'bat'
alias g    'git'
alias sha  'sha256sum -c --ignore-missing'
alias md5  'md5sum -c --ignore-missing'

# func
# ----
alias gmm  'fish_mount'
alias gmu  'fish_umount'
alias rgpg 'echo RELOADAGENT | gpg-connect-agent'

# git
# ---
alias gst    'git status'
alias gd     'git diff'
alias gdc    'git diff --cached'
alias gp     'git push'
alias gd     'git diff'
alias gf     'git fetch'
alias gpu    'git pull'
alias gm     'git merge'
alias gri    'git rebase -i'
alias grc    'git rebase --continue'

alias ga     'git add'
alias gaa    'git add -A'
alias gc     'git commit -v'
alias gc!    'git commit -v --amend'
alias gca    'git commit -v -a'
alias gca!   'git commit -v -a --amend'
alias gcmsg  'git commit -m'

alias grs    'git restore --staged'
alias grh    'git reset HEAD'
alias grhh   'git reset HEAD --hard'
alias grh1   'git reset HEAD~1'
alias grhh1  'git reset HEAD~1 --hard'
alias gclean 'git reset --hard; and git clean -dfx'

alias gco    'git checkout'
alias gcm    'git checkout master'
alias gb     'git branch'
alias gbv    'git branch -vv'
alias gba    'git branch -a'

alias gcl    'git config --list'
alias gcount 'git shortlog -sn'
alias gl     'git log --stat --max-count 10'
alias gla    'git log --stat --all'
alias gl1    'git log --stat -n 1'
alias glg    'git log --graph --max-count 10'
alias glga   'git log --graph --decorate --all'
alias glo    'git log --oneline'
alias glog   'git log --oneline --graph --abbrev-commit --decorate'
alias gloga  'git log --oneline --graph --abbrev-commit --decorate --all'
