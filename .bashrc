# INCLUDE THIS IN .bash_profile and/or .profile if needed
#if [ -n "$BASH_VERSION" ]; then
#    # include .bashrc if it exists
#    if [ -f "$HOME/.bashrc" ]; then
#        . "$HOME/.bashrc"
#    fi
#fi

# return if not interactive
case $- in
    *i*) ;;
      *) return;;
esac

# else launch tmux (no exec to allow for detatching)
#if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ] && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]]; then
#    tmux new-session -A -s ${USER} >/dev/null 2>&1
#fi

export PROMPT_COMMAND='history -a'
export HISTSIZE=10000
export HISTFILESIZE=20000
export EDITOR=vim
export VISUAL=vim
export HISTCONTROL=ignoreboth:erasedups

shopt -s cdspell
shopt -s dirspell 2>/dev/null
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s lithist
shopt -s histappend
shopt -s checkwinsize

# Better pattern matching
shopt -s globstar
shopt -s dotglob
shopt -s extglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# common aliases
alias ll='ls -alhF'
alias la='ls -AF'
alias l='ls -CF'
alias _='sudo '
alias q='exit'
alias c='clear'
alias ..='cd ..'
alias .='ls'
alias -- -='cd -'
alias sl='ls'
alias python='python3'
alias open='xdg-open'

# handy flags
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# fix terminal not fully functional when SSHing
alias ssh="TERM=xterm-256color ssh"

# for seperate alias
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# add git integration & VIRTUAL_ENV if you are into that
if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\] "
else
    PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

# Update PATH
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/sbin
command -v go >/dev/null 2>&1 && export PATH=$PATH:$(go env GOPATH)/bin
[ -f "~/.ghcup/env" ] && . "~/.ghcup/env"

# command not found hook
command -v pkgfile >/dev/null 2>&1 && source /usr/share/doc/pkgfile/command-not-found.bash

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# history autocomplete
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
    man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
    }
fi

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion &>/dev/null
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
