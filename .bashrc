
for file in "${XDG_CONFIG_HOME:-$HOME/.config}/profile.d/"*.sh; do
  source "$file"
done

#start_time=$(date +%s%N)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#export LIBVIRT_DEFAULT_URI="qemu:///system"

# ================ History ========================
HISTSIZE=2000
HISTFILE="$XDG_STATE_HOME"/bash/history

# ============ Plugins ======================
source /usr/share/doc/pkgfile/command-not-found.bash

# ============== Configuration ====================

# ============== Inhibit sleep if SSH	==============
if [ "$SSH_CLIENT" ] &&
     ! pstree -ps $$ |
       grep -q -- '-systemd-inhibit(' >/dev/null; then

  echo "Inhibit automatic standby"
  exec /usr/bin/systemd-inhibit \
    --what="idle" --who="SSH" --why='Interactive SSH session' -- \
    "$SHELL" "$@"

fi

# ================== Configure prompt ================
__get_terminal_column() {
  exec < /dev/tty
  local oldstty=$(stty -g)
  stty raw -echo min 0
  echo -en "\033[6n" > /dev/tty
  local pos
  IFS=';' read -r -d R -a pos
  stty "$oldstty"
  echo "$(( pos[1] - 1 ))"
}

__configure_prompt() {
  if [ "$(__get_terminal_column)" != 0 ]; then
    echo
  fi
}

PROMPT_COMMAND="__configure_prompt;$PROMPT_COMMAND"

# ============ TTY Specific =====================
ttyinit="echo -ne '\e[?25h' ; echo -ne '\e[11;0]'"
if [[ $XDG_SESSION_TYPE == "tty" ]]; then
	eval "$ttyinit"
fi
alias ttyinit=$ttyinit

# ============== PS1 ============================
PS1='\[\e[38;5;77m\]┌─[\u@\h][\[\e[0m\]\w\[\e[38;5;77m\]]\[\033[0m\]\n\[\e[38;5;77m\]└₴\[\e[0m\] '


# The Fuck is slow as fuck
#eval "$(thefuck --alias)"

#end_time=$(date +%s%N)
#echo "Bash startup time: $(( (end_time - start_time) / 1000000 )) ms"

# ======= SSH Friendly =======
#PS1='\[\e[38;5;77m\][\u@\h:\w]\$ \[\033[0m\]'

# ======= Custom =======
#PS1='\[\e[38;5;77m\]┌─[\[\e[0m\]\w\[\e[38;5;77m\]]\n└[\u@\h]\\$ \[\033[0m\]'

# ======= Custom Test =======
# PS1='\[\e[38;5;77m\]┌─[\[\e[0m\]\w\[\e[38;5;77m\]]\[\033[0m\]\n\[\e[38;5;77m\]└[\u@\h]\\$\[\033[0m\] '

# Vanilla Ukrainian export PS1="\[\e[38;5;184m\]\u\[\e[38;5;184m\]@\[\e[38;5;69m\]\h:\[\e[38;5;159m\]\w\$ \[\e[0m\]"
# PS1="\[\e[36m\]\u@\h:\w\$ \[\e[0m\]"

# https://bbs.archlinux.org/viewtopic.php?pid=1068202#p1068202
# PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\e[38;5;69m\]\h'; else echo '\[\e[38;5;184m\]\u\[\033[0;37m\]@\[\e[38;5;69m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"
