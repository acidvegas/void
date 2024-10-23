[[ $- != *i* ]] && return

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export GNUPGHOME="$HOME/.local/share/gnupg"
export GPG_TTY=$(tty)

export GOPATH=$HOME/dev/go
export CARGO_HOME=$HOME/dev/cargo
export PATH=$PATH:/opt:$HOME/.local/bin:$HOME/dev/go/bin:$HOME/dev/cargo/bin:$GOPATH/bin

export XINITRC="$HOME/.config/X11/xinitrc"

for item in $(ls $HOME/.local/share/bash); do
    source $HOME/.local/share/bash/$item
done

if [ "$(id -u)" -eq 0 ]; then
    export PS1="\e[38;5;237m\T\e[0m \e[38;5;196m\u@\h\e[0m \e[38;5;226m\w \e[0m: "
else
    export PS1="\e[38;5;237m\T\e[0m \e[38;5;41m\u@\h\e[0m \e[38;5;69m\w \e[0m: "
fi
