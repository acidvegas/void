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

ctainr() {
	NAME=$1
	lxc storage create $NAME-pool dir #Add "source=/path/to/storage" to use a different directory
	lxc launch images:debian/12 $NAME-container -s $NAME-pool
	sleep 10 # Delay to allow the container to start and get an IP address from the DHCP server
	CONTAINER_IP=$(lxc list | grep $NAME-container | awk '{print $6}')
	lxc config device override $NAME-container eth0
	lxc config device set $NAME-container eth0 ipv4.address $CONTAINER_IP
	lxc config set $NAME-container boot.autostart true
	lxc exec $NAME-container -- apt update  -y
	lxc exec $NAME-container -- apt upgrade -y
	lxc exec $NAME-container -- apt install unattended-upgrades -y
	lxc exec $NAME-container -- useradd -m -s /bin/bash agent
	lxc exec $NAME-container -- journalctl --vacuum-time=1d
	lxc exec $NAME-container -- sh -c 'printf "[Journal]\nStorage=volatile\nSplitMode=none\nRuntimeMaxUse=500K\n" > /etc/systemd/journald.conf'
	lxc exec $NAME-container -- systemctl restart systemd-journald
	echo "The $NAME container has been created and is available at $CONTAINER_IP"
	echo ""
	echo "Forward ports to the container using the following command:"
	echo "    lxc config device add $NAME-container $NAME-PORT_NAME proxy listen=tcp:[0.0.0.0]:HOST_PORT connect=tcp:[$CONTAINER_IP]:CONTAINER_PORT"
	echo ""
	echo "Tap in to your container with the following command:"
	echo "    lxc exec $NAME-container -- bash"
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

gcp() {
	git add .
	git commit -S -m "$*"
	git push
}

hf() {
	curl -F file=@$1 https://hardfiles.org/ # yeah thats right motherfucker, real bay shit, for real bay motherfuckers.
}

iso2usb() {
	sudo dd bs=4M if=$1 of=$2 status=progress
	sudo /bin/sync
}

keys() {
	echo "Ctrl + a               move to the beginning of line."
	echo "Ctrl + d               if you've type something, Ctrl + d deletes the character under the cursor, else, it escapes the current shell."
	echo "Ctrl + e               move to the end of line."
	echo "Ctrl + k               delete all text from the cursor to the end of line."
	echo "Ctrl + l               CLEAR"
	echo "Ctrl + n               DOWN"
	echo "Ctrl + p               UP"
	echo "Ctrl + q               to resume output to terminal after Ctrl + s."
	echo "Ctrl + r               begins a backward search through command history.(keep pressing Ctrl + r to move backward)"
	echo "Ctrl + s               to stop output to terminal."
	echo "Ctrl + t               transpose the character before the cursor with the one under the cursor, press Esc + t to transposes the two words before the cursor."
	echo "Ctrl + u               cut the line before the cursor; then Ctrl + y paste it"
	echo "Ctrl + w               cut the word before the cursor; then Ctrl + y paste it"
	echo "Ctrl + x + backspace   delete all text from the beginning of line to the cursor."
	echo "Ctrl + x + Ctrl + e    launch editor defined by \$EDITOR to input your command. Useful for multi-line commands."
	echo "Ctrl + z               stop current running process and keep it in background. You can use \`fg\` to continue the process in the foreground, or \`bg\` to continue the process in the background."
	echo "Ctrl + _               UNDO"
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

title() {
	echo -ne "\033]0;$1\007"
}

updater() {
	xbps-install -Su
	xbps-install -u xbps
	xbps-install -Su
	vkpurge rm all
	pdtm -ua

}
