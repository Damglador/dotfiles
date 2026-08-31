#!/bin/sh

# Disable Ctrl+Z as terminal suspend
stty susp undef

if [ "$(uname -o)" = "Android" ]; then
  export EDITOR="micro"
else
  export EDITOR="nvim"
fi

alias sudo='sudo ' # Allow aliases when using sudo

# ================ Aliases ==================
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias zed="zeditor"
[ "$(command -v micro)" ] && alias nano="micro"
[ "$(command -v bat)" ] && alias cat="bat"
alias py="python"
alias ipconfig="ip r"
alias ff="fastfetch"
alias matrix="cmatrix"
alias ":q"=exit

# ============== Configuration ====================
alias ls='ls --color -h'
alias ip="ip --color"
alias grep='grep --color'
alias diff='diff --color'
# Ймовірно має бути у конфігу lf як loadable.
# Треба буде зробити модульну систему еліасів і змінних
lfcd() {
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -print-last-dir "$@")" || return
}
alias lf=lfcd
alias unshare="sudo unshare -n sudo -u damglador"
alias netjail="firejail --net=none --noprofile"
alias bat="bat --paging=never --wrap=never --plain"
alias free="free -h"
if [ ! -f /usr/bin/yay ] && [ "$(uname -o)" != Android ]; then
  alias yay="sudo pacman"
fi

# ================ XDG folders ==================
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
