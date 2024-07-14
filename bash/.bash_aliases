#!/bin/sh
# .bash_aliases - developed by acidvegas (https://git.acid.vegas/void)

# colors
alias diff='diff --color=auto'
alias dmesg='dmesg --color=auto'
alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias ip='ip -color=auto'
alias ls='ls --color=auto'
alias ncdu='ncdu --color dark -rr'
alias tree='tree -C'
alias vdir='vdir --color=auto'

# rewrites
alias cp='cp -i'
alias exa='exa -aghl --git'
alias mv='mv -i'
alias pip='pip3'
alias progress='progress -m'
alias python='python3'
alias vlock='vlock -a'
alias wget='wget -q --show-progress'

# git
alias gitfix='git push -u origin HEAD'
alias rmcommits="git checkout --orphan latest_branch && git add -A && git commit -S -am \"Initial commit\" && git branch -D master && git branch -m master && git push -f origin master"
alias nrmcommits="git checkout --orphan latest_branch && git add -A && git commit -S -am \"Initial commit\" && git branch -D main && git branch -m main && git push -f origin main"

# random
alias ..="cd ../"
alias dropkey="dropbearkey -y -f .dropbear/key | head -n 2 | tail -n 1"
alias dump='setterm -dump 1 -file screen.dump'
alias newnym='echo -e "AUTHENTICATE \"CHANGEME\"\r\nSIGNAL NEWNYM\r\nQUIT" | nc 127.0.0.1 9051'
alias mdcat='glow'
alias mkgz='tar -cvzf'
alias myip='curl 4.icanhazip.com && curl 6.icanhazip.com'
alias pubkey='ssh-keygen -y -f ~/.ssh/key'
alias pydebug='python -m trace -t'
alias torch='curl -s https://check.torproject.org | grep "Congratulations"'
alias y2m='youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 -o "%(title)s.%(ext)s" --no-cache-dir --no-call-home'
alias up='sudo mount -o remount,rw /boot && sudo xbps-install -Su && sudo mount -o remount,ro /boot'

# scripts
alias dbc='~/.scripts/dbc'
alias gitremote='~/.scripts/gitremote'
alias irc2ansi='python3 ~/.scripts/irc2ansi.py'
alias mutag='~/.scripts/mutag'
alias pass='~/.scripts/pass'
alias shotz='~/.scripts/shotz'
alias todo='~/.scripts/todo'