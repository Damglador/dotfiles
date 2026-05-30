#!/bin/sh
# Force system file picker
#export QT_QPA_PLATFORMTHEME=xdgdesktopportal # Do not use with Plasma session
export GTK_USE_PORTAL=1 GDK_DEBUG=portals

stty susp undef

export EDITOR=micro

#	    _    _ _
#	   / \  | (_) __ _ ___  ___  ___
#	  / _ \ | | |/ _` / __|/ _ \/ __|
#	 / ___ \| | | (_| \__ \  __/\__ \
#	/_/   \_\_|_|\__,_|___/\___||___/
#
alias sudo='sudo ' # Allow aliases when using sudo

# ================ Aliases ==================
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias zed="zeditor"
[ $(command -v micro) ] && alias nano="micro"
[ $(command -v bat) ] && alias cat="bat"
alias py="python"
alias ipconfig="ip r"
alias ff="fastfetch"
alias matrix="cmatrix"

# ============== Configuration ====================
alias ls='ls --color -h'
alias ip="ip --color"
alias grep='grep --color'
alias diff='diff --color'
# Ймовірно має бути у конфігу lf як loadable.
# Треба буде зробити модульну систему еліасів і змінних
lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")" || return
}
alias lf=lfcd
alias unshare="sudo unshare -n sudo -u damglador"
alias netjail="firejail --net=none --noprofile"
alias darling="DPREFIX=~/.local/share/darling darling"
alias bat="bat --paging=never --wrap=never --plain"
alias free="free -h"
if [ ! -f /usr/bin/yay ] && [[ $(uname -o) != Android ]]; then
  alias yay="sudo pacman"
fi

# ================ XDG folders ==================
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

export PYTHONPATH="$PYTHONPATH:/home/damglador/.local/lib/python3.12/site-packages:./.venv/lib/python3.13/site-packages/"
append_path () {
    case ":$PATH:" in
        *:"$1":*);;
        *) PATH="${PATH:+$PATH:}$1"
    esac
}

append_path "$XDG_DATA_HOME/cargo/bin"
append_path "$HOME/Scripts"
append_path "$HOME/.local/bin"
append_path "$XDG_STATE_HOME/nix/profile/bin"
append_path "."

export PATH
export PATH="$XDG_DATA_HOME/npm/bin:$PATH"
