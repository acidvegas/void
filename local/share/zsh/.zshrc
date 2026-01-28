# Set Locales
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set GPG TTY
export GPG_TTY="$(tty)"

# Custom Paths
export ANSIBLE_HOME="$HOME/.local/share/ansible"
export ANSIBLE_LOCAL_TEMP="$HOME/.cache/ansible/tmp"
export ANSIBLE_REMOTE_TEMP="$HOME/.cache/ansible/tmp"
export CARGO_HOME="$HOME/dev/cargo"
export GNUPGHOME="$HOME/.local/share/gnupg"
export GOPATH="$HOME/dev/go"
export XINITRC="$HOME/.config/X11/xinitrc"
export WINEPREFIX="$HOME/.config/wine"
export PATH="$PATH:/opt:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin:$HOME/.local/bin/scripts"

# Custom Colors
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# Source Bash Fragments
if [[ -d "$HOME/.local/share/bash" ]]; then
    for item in "$HOME/.local/share/bash"/*; do
        [[ -f "$item" ]] && source "$item"
    done
fi

# Set options
setopt NO_BEEP
setopt INTERACTIVE_COMMENTS

# Set History
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# Enable Completion System
ZCOMPDUMP="$ZDOTDIR/.zcompdump"
autoload -Uz compinit
[[ -n ${ZCOMPDUMP}(#qN.mh+24) ]] && compinit -d "$ZCOMPDUMP" || compinit -C -d "$ZCOMPDUMP"

# Set Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^I' autosuggest-accept

# Prompt based on if the user is root or not
setopt PROMPT_SUBST
if [[ $EUID -eq 0 ]]; then
    PROMPT=$'%F{61}%D{%I:%M:%S}%f %F{203}%n@%m%f %F{212}%~%f: '
else
    PROMPT=$'%F{61}%D{%I:%M:%S}%f %F{141}%n@%m%f %F{117}%~%f: '
fi

# Syntax Highlighting (must be last)
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh