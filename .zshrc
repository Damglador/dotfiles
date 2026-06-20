
for file in "${XDG_CONFIG_HOME:-$HOME/.config}/profile.d/"*.sh; do
  source "$file"
done

zstyle :compinstall filename "$HOME/.zshrc"
# === Move files to XDG directories
XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}
XDG_STATE_HOME=${XDG_STATE_HOME:-${HOME}/.local/state}
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}

#[ ! -d "$XDG_CONFIG_HOME"/zsh ] && mkdir -p "$XDG_CONFIG_HOME"/zsh
[ ! -d "$XDG_CACHE_HOME"/zsh ] && mkdir -p "$XDG_CACHE_HOME"/zsh

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# ========== History ================
# Docs: https://zsh.sourceforge.io/Doc/Release/Options.html
HISTFILE="$XDG_STATE_HOME"/zsh/history
[ ! -d "$(dirname "$HISTFILE")" ] && mkdir -p "$(dirname "$HISTFILE")"
HISTSIZE=5000
SAVEHIST=${HISTSIZE}
setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
setopt SHARE_HISTORY            # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
#setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
setopt HIST_REDUCE_BLANKS

# ========= Configuration ==========
# Source all environmental variables.
set -o allexport # export all sourced
for f in "${XDG_CONFIG_HOME}"/environment.d/*.conf; do
    [ -f "$f" ] || continue
    source "$f"
done
set +o allexport # disable exporting sourced
# === Colors in tty
[[ "$XDG_SESSION_TYPE" == "tty" ]] && TERM=xterm-256color
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Color Tab completion
setopt autocd # cd in typed directories
#setopt correct # suggest commands if typed doesn't exist
autoload -U colors && colors # idk some colors
autoload -Uz select-word-style && select-word-style bash # Better word erase
eval $(fzf --zsh) # Fzf integration

zstyle ':completion:*' menu select
zmodload zsh/complist

# Breaks autosuggestions https://github.com/zsh-users/zsh-autosuggestions/issues/756
#setopt KSH_ARRAYS # zero-based indexing,
PROMPT='%F{77}┌─[%n@%m][%f%~%F{77}]%f
%F{77}└%%%f ' # Prompt

PROMPT_EOL_MARK="" # Disable end of line sign

#	 _  __          _     _           _
#	| |/ /___ _   _| |__ (_)_ __   __| |___
#	| ' // _ \ | | | '_ \| | '_ \ / _` / __|
#	| . \  __/ |_| | |_) | | | | | (_| \__ \
#	|_|\_\___|\__, |_.__/|_|_| |_|\__,_|___/
#	          |___/

bindkey -e
# Arrow key history for current command
bindkey "^[[A"	history-search-backward # Історія уверх для поточної команди
bindkey "^[[B"	history-search-forward  # Історія униз для поточної команди
bindkey ";5A"	up-line-or-history      # Гортати історію вверх
bindkey ";5B"	down-line-or-history    # Гортати історію униз
bindkey ';5D'	backward-word           # Одне слово ліворуч на Ctrl+Left
bindkey ';5C'	forward-word            # Одне слово праворуч на Ctrl+Righ
bindkey '^\b'	backward-kill-word      # Стерти слово ліворуч (Ctrl+Backspace)
bindkey ';5~'	kill-word               # Стерти слово праворуч (Ctrl+Del)
bindkey '5~'	kill-word
bindkey '^[[3~' delete-char
bindkey -r '^G'

#	 ____  _             _
#	|  _ \| |_   _  __ _(_)_ __  ___
#	| |_) | | | | |/ _` | | '_ \/ __|
#	|  __/| | |_| | (_| | | | | \__ \
#	|_|   |_|\__,_|\__, |_|_| |_|___/
#	               |___/

ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Plugin list
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-autosuggestions
zinit snippet https://raw.github.com/ohmyzsh/ohmyzsh/master/plugins/fzf/fzf.plugin.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
# === Search pacman if command is not found
[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Don't paste trailing new lines
bracketed-paste() {
    zle ."$WIDGET" && LBUFFER=${LBUFFER%$'\n'}
}
zle -N bracketed-paste

# ==== Inhibit idle if ssh session
if [ "$SSH_CLIENT" ] && \
    command -v systemd-inhibit > /dev/null 2>&1 && \
    ! pstree -ps $$ | grep -q systemd-inhibit; then

  echo "Shell will ihibit idle suspend."
  exec /usr/bin/systemd-inhibit \
    --what="idle" --who="SSH" --why='Interactive SSH session' -- \
    "$SHELL" "$@"
fi

if [ "$XDG_SESSION_TYPE" = "tty" ]; then
  # Fix GPG password promt
  # https://superuser.com/questions/520980/how-to-force-gpg-to-use-console-mode-pinentry-to-prompt-for-passwords
  export GPG_TTY=$(tty)
fi

test -f ~/.profile && source ~/.profile
