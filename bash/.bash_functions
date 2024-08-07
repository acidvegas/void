#!/bin/sh
# .bash_functions - developed by acidvegas (https://git.acid.vegas/void)

cheat() {
	curl cht.sh/$1
}

color() {
	for color in {0..255}; do
		printf "\e[48;5;%sm  %3s  \e[0m" $color $color
		if [ $((($color + 1) % 6)) == 4 ]; then
			echo
		fi
	done
}

cctain() {
	NAME=$1
	incus storage create $NAME-pool dir
	incus launch images:debian/12 $NAME-container -s $NAME-pool	
	incus config set $NAME-container boot.autostart true
	sleep 10 # Delay to allow the container to start and get an IP address from the DHCP server
	incus exec $NAME-container -- apt update  -y
	incus exec $NAME-container -- apt upgrade -y
	incus exec $NAME-container -- apt install -y git nano unattended-upgrades wget
	incus exec $NAME-container -- useradd -m -s /bin/bash agent
	incus exec $NAME-container -- journalctl --vacuum-time=1d
	incus exec $NAME-container -- sh -c 'printf "[Journal]\nStorage=volatile\nSplitMode=none\nRuntimeMaxUse=500K" > /etc/systemd/journald.conf'
	incus exec $NAME-container -- systemctl restart systemd-journald
}

extract() {
	if [ ! -z "$1" ]; then
		if [ -f $1 ]; then
			case $1 in
				*.tar.bz2) tar xvjf $1    ;;
				*.tar.gz)  tar xvzf $1    ;;
				*.tar.xz)  tar xvJf $1    ;;
				*.lzma)    unlzma $1      ;;
				*.bz2)     bunzip2 $1     ;;
				*.rar)     unrar x -ad $1 ;;
				*.gz)      gunzip $1      ;;
				*.tar)     tar xvf $1     ;;
				*.tbz2)    tar xvjf $1    ;;
				*.tgz)     tar xvzf $1    ;;
				*.zip)     unzip $1       ;;
				*.Z)       uncompress $1  ;;
				*.7z)      7z x $1        ;;
				*.xz)      unxz $1        ;;
				*)         echo "$1 - unknown archive format" ;;
			esac
		else
			echo "$1 - file does not exist"
		fi
	fi
}

flash() {
	sudo dd bs=4M if=$1 of=$2 status=progress
	sudo /bin/sync
}

gcp() {
	git add . && git commit -S -m "$*" && git push
}

hf() {
	curl -F file=@$1 https://hardfiles.org/ # yeah thats right motherfucker, real bay shit, for real bay motherfuckers.
}

mntusb() {
	sudo mount $1 /mnt -o uid=$(id -u),gid=$(id -g)
}

repo() {
	if [ ! -z "$1" ]; then
		for d in $(find $HOME/dev/git -type d -name mirrors -prune -o -type d -name .git -print); do
			r=$(basename $(dirname $d))
			if [ $1 = $r ]; then
				cd $d
			fi
		done
	fi
}

qr() {
	curl qrenco.de/$1
}

rnd() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $1 | head -n 1
}

backup() {
	DATA="dev dl doc media .gnupg .ssh .bogoya"
	DEST=backup/main
	for d in $DATA; do
		rsync -avzh --progress --delete $HOME/$d blackbox:$DEST
	done
}

# Legacy comand for setting terminal titles in tabbed, might play with this ANSI escape later...
#title() {
#	echo -ne "\033]0;$1\007"
#}