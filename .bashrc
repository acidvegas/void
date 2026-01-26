# Set locales
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set GPG TTY
export GPG_TTY=$(tty)

# Custom paths
export ANSIBLE_HOME="$HOME/.local/share/ansible"
export ANSIBLE_LOCAL_TEMP="$HOME/.cache/ansible/tmp"
export ANSIBLE_REMOTE_TEMP="$HOME/.cache/ansible/tmp"
export CARGO_HOME=$HOME/dev/cargo
export GNUPGHOME="$HOME/.local/share/gnupg"
export GOPATH=$HOME/dev/go
export XINITRC="$HOME/.config/X11/xinitrc"
export WINEPREFIX="$HOME/.config/wine"

# Custom colors
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# Define paths
export PATH=$PATH:/opt:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin:$HOME/.local/bin/scripts

# Source all bash files in the .local/share/bash directory
for item in $(ls $HOME/.local/share/bash); do
    source $HOME/.local/share/bash/$item
done

# Prompt based on if the user is root or not
if [ "$(id -u)" -eq 0 ]; then
    export PS1="\e[38;5;61m\T\e[0m \e[38;5;203m\u@\h\e[0m \e[38;5;212m\w \e[0m: "
else
    export PS1="\e[38;5;61m\T\e[0m \e[38;5;141m\u@\h\e[0m \e[38;5;117m\w \e[0m: "
fi