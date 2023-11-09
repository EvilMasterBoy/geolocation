#!/bin/bash
br="\033[91m"
bg="\033[92m"
by="\033[93m"
bb="\033[94m"
bp="\033[95m"
bc="\033[96m"
re="\033[00m"
bl="\033[5m"
pkginstall(){
	pkgs=(curl jq)
	for pkg in ${pkgs[@]}; do
		type $pkg &>/dev/null || {
			if [[ $(command -v pkg) ]]; then
				pkg install $pkg -y
			elif [[ $(command -v apt) ]]; then
				apt install $pkg -y
			elif [[ $(command -v apt-get) ]]; then
				apt-get install $pkg -y
			elif [[ $(command -v pacman) ]]; then
				pacman -S $pkg --noconfirm
			elif [[ $(command -v dnf) ]]; then
				dnf -y install $pkg
			elif [[ $(command -v yum) ]]; then
				yum -y install $pkg
			elif [[ $(command -v brew) ]]; then
				brew install $pkg
			fi
		}
	done
}
setup(){
	path=$(echo $PATH | cut -d ":" -f 1)
	if [[ -f geolocation ]]; then
		mv geolocation $path/
		chmod +x ${path}/geolocation
	fi
	xdg-open https://t.me/FSociety_MM
	sleep 5
	clear
	echo -e "
${bl}${br}██╗     ██╗   ██╗ ██████╗ █████╗ ███████╗${re}
${bl}${br}██║     ██║   ██║██╔════╝██╔══██╗██╔════╝${re}
${bl}${br}██║     ██║   ██║██║     ███████║███████╗${re}
${bl}${br}██║     ██║   ██║██║     ██╔══██║╚════██║${re}
${bl}${br}███████╗╚██████╔╝╚██████╗██║  ██║███████║${re}
${bl}${br}╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝${re}\n
${bb}DEVELOPER      ${by}=${bb} ${br}LUCAS                   ${re}
${bb}CHANNEL LINK   ${by}=${bb} ${bc}\e[4mhttps://t.me/FSociety_MM${re}
	"
	echo -e "\t${bb}[${by}*${bb}] ${bg}run Type '${br}geolocation ipAddress${bg}'"
	echo -e "\t${bb}[${by}*${bb}] ${bg}example  '${br}geolocation 149.154.167.99${bg}'"
	exit
}
cr(){
	if [[ $EUID != 0 ]]; then
		echo "Please run as root"
		exit
	fi
}
case $(uname -o) in
	Android) pkginstall && setup;;
	*) cr && pkginstall && setup;;
esac
