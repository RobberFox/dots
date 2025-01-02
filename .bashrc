# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    (xterm-color|*-256color|xterm-kitty) color_prompt=yes;;
esac

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P01a1b26" #black
    echo -en "\e]P8404040" #darkgrey
    echo -en "\e]P1d81111" #darkred
    echo -en "\e]P9fc0a0a" #red
    echo -en "\e]P200cd00" #darkgreen
    echo -en "\e]PA00ff00" #green
    echo -en "\e]P3cdcd00" #brown
    echo -en "\e]PBffff00" #yellow
    echo -en "\e]P41093f5" #darkblue
    echo -en "\e]PC11b5f6" #blue
    echo -en "\e]P5cd00cd" #darkmagenta
    echo -en "\e]PDff00ff" #magenta
    echo -en "\e]P600cdcd" #darkcyan
    echo -en "\e]PE00ffff" #cyan
    echo -en "\e]P7bec6df" #lightgrey
    echo -en "\e]PFc8d3f5" #white
    clear #for background artifacting
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[01;30;48;2;122;162;247m\] \u@\h \[\e[0m\]\[\e[01;34;48;2;46;46;66m\] \w \[\e[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\e[01;30;48;2;122;162;247m\] \u@\h \[\e[0m\]\[\e[01;34;48;2;46;46;66m\] \w \[\e[0m\] '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Created by `pipx` on 2024-06-27 12:14:48
export PATH="$PATH:/home/robert/.local/bin"

#rm precaution
alias rm='echo "This is not the command you are looking for."; false'
alias 3n='nnn -ae'
alias trm='trash-put'
alias tls='trash-list'

export NNN_PLUG='a:preview-tui'

#fuzzy finder
export FZF_DEFAULT_OPTS="--height=50% --info=inline --border --color=border:#3B4261,bg+:#292E42"
export FZF_DEFAULT_COMMAND="fdfind -H -t f . $HOME"
bind -x '"\C-f":nvim "$(fzf)"'

bind -x '"\C-x\C-s":cd "$(fdfind -H -t d . $HOME | fzf)"'
bind '"\C-g":"\C-x\C-s\n"'
bind -x '"\C-n":cd "$(fdfind -H -I -t d . $HOME | fzf)"'

if [[ -n $DISPLAY ]]; then
  copy_line_to_x_clipboard () {
    printf %s "$READLINE_LINE" | xclip -selection CLIPBOARD
  }
  bind -x '"\C-y": copy_line_to_x_clipboard' # binded to ctrl-y
fi

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'

up ()
{
    local old="$PWD"
    for i in $(seq "${1:-1}"); do
        cd ..
    done
    OLDPWD="$old"
}

export PATH="$HOME/.config/nvm/versions/node/v22.9.0/bin:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.obsidian_key.sh
