[[ $- != *i* ]] && return

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GPG_TTY=$(tty)
export GOPATH=$HOME/dev/go
export PATH=$HOME/.local/bin:$PATH:$GOPATH/bin

[ -f $HOME/.bash_aliases   ] && source $HOME/.bash_aliases
[ -f $HOME/.bash_functions ] && source $HOME/.bash_functions

if [ "$(id -u)" -eq 0 ]; then
    export PS1="\e[38;5;237m\T\e[0m \e[38;5;196m\u@\h\e[0m \e[38;5;226m\w \e[0m: "
else
    export PS1="\e[38;5;237m\T\e[0m \e[38;5;41m\u@\h\e[0m \e[38;5;69m\w \e[0m: "
fi
