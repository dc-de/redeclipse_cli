#!/bin/bash
### Red Eclipse CLI ###
CLIVER='v0.0.1'
<<COMMENT
License:
This work by "dc" is licensed under the Creative Commons 
Attribution-ShareAlike 4.0 International License. To view a copy 
of this license, visit http://creativecommons.org/licenses/by-sa/4.0/.
COMMENT

###> config <###

#dependencies
PACKAGESDEBIANUBUNTU='git curl libsdl2-mixer-2.0-0 libsdl2-image-2.0-0 libsdl2-2.0-0'
PACKAGESFEDORA='git curl SDL2 SDL2_mixer SDL2_image'
PACKAGESSUSE='git curl SDL2 SDL2_mixer SDL2_image'
PACKAGESGENTOO='git curl SDL2 SDL2_mixer SDL2_image'
PACKAGESARCH='git curl sdl2_mixer sdl2_image enet hicolor-icon-theme'

#git path
GITPATH='https://github.com/redeclipse/base.git'

#git branch
DEVELOPMENT='master'
STABLE='stable'

#install dir
DIRDEV='redeclipse-dev'
DIRSTABLE='redeclipse'
DIRDEVSERVER='redeclipse-dev-server'
DIRSTABLESERVER='redeclipse-server'

#Red Eclipse version
VERDEVELOPMENT='v2.0.1'
VERSTABLE='v2.0.0'

###> end of config <###

######################
######written#by######
######################
###██████╗##██████╗###
###██╔══██╗██╔════╝###
###██║##██║██║########
###██║##██║██║########
###██████╔╝╚██████╗###
###╚═════╝##╚═════╝###
######################


#defaults init
function install_defaults()
{
if [[ $EUID -ne 0 ]]; then
	PUSER=$USER
else
	PUSER=$SUDO_USER
fi
INSTALLDIR=/home/$PUSER/.redeclipse/game
INSTALLDIRDEV=$INSTALLDIR/$DIRDEV
INSTALLDIRSTABLE=$INSTALLDIR/$DIRSTABLE

#dialog defaults
TASK="TASK"
ERROR="none"

#attributes
BOLD="$(tput bold)"
NC="$(tput sgr0)"
BLINK="$(tput blink)"

#colors

#normal ones
N_BLACK="$(tput setaf 0)"
N_RED="$(tput setaf 1)"
N_GREEN="$(tput setaf 2)"
N_YELLOW="$(tput setaf 3)"
N_BLUE="$(tput setaf 4)"
N_PURPLE="$(tput setaf 5)"
N_CYAN="$(tput setaf 6)"
N_WHITE="$(tput setaf 7)"

#bold ones, naming for compatibility

#actually gray
BLACK="${BOLD}${N_BLACK}"
RED="${BOLD}${N_RED}"
GREEN="${BOLD}${N_GREEN}"
YELLOW="${BOLD}${N_YELLOW}"
BLUE="${BOLD}${N_BLUE}"
PURPLE="${BOLD}${N_PURPLE}"
CYAN="${BOLD}${N_CYAN}"

#actually bold white
GRAY="${BOLD}${N_WHITE}"

#actually bold blink
REDBLINK="${BLINK}${RED}"
BLUEBLINK="${BLINK}${BLUE}"

#script dir path
SCRIPTDIRPATH=$(dirname "$0") &> /dev/null
SCRIPTDIRPATH=$(cd "$SCRIPTDIRPATH" && pwd) &> /dev/null
if [[ -z "$SCRIPTDIRPATH" ]] ; then
  ERROR="Script path is not accessible!"
fi

#script name
SCRIPTNAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
SFILE=$SCRIPTNAME
SCRIPTNAMESHORT=$(echo "$SFILE" | sed 's/\.[^.]*$//')
SCRIPTEXTENSION=$(echo "$SFILE" | sed 's/^.*\.//')
}
install_defaults
#defaults end

function dofolder()
{
cd '/home/'$PUSER
if [ -d ".redeclipse" ]; then
    ERROR="Path is not accessible!"
else
	mkdir ".redeclipse" &> /dev/null
fi
cd '.redeclipse'
if [ -d "game" ]; then
    ERROR="Path is not accessible!"
else
	mkdir "game" &> /dev/null
fi
cd "$SCRIPTDIRPATH"
ERROR="none"
}

function autosudo()
{
if [[ $EUID -ne 0 ]]; then
	EXECSUDO=sudo
	PUSER=$USER
	SUDOSTATMSG="False"
else
	EXECSUDO=
	PUSER=$SUDO_USER
	SUDOSTATMSG="True"
fi
}

function forcesudo()
{
if [[ $EUID -ne 0 ]]; then
	clear
	main
	echo -e "${PURPLE}You need to be sudo to $SUDOACTIONMSG ${RED}Red Eclipse${NC}${PURPLE}!${NC}"
	printf "\n"
	echo -e "${BLUEBLINK}The script restart with sudo automatically again!${NC}" && sleep 3
	clear
	main
	ERROR="You are not sudo yet! Try it again!"
	echo -e "${PURPLE}You need to be sudo to $SUDOACTIONMSG ${RED}Red Eclipse${NC}${PURPLE}!${NC}"
	printf "\n"
	echo -e "${BLUE}Please enter your password to run the script as sudo again:${NC}"
	sudo bash "$SCRIPTDIRPATH/$SCRIPTNAME"
	ERROR="none"
	clear
	exit
fi
}

function logo()
{
echo -e "${RED}                                   ..                                     ${NC}"
echo -e "${RED}                        ..:${GRAY}-======--${RED}::......                              ${NC}"
echo -e "${RED}               ......:${GRAY}=*#%@@@@@@@@@%#*=-${RED}::::::..                          ${NC}"
echo -e "${RED}           ....:::-${GRAY}=#%@@@@@@@@@@@@@@@@@%*-${RED}::::::..                        ${NC}"
echo -e "${RED}        ...::::--${GRAY}+#@@@@@@@@@@@@@${BLACK}%%%%%%%%%#*=-${RED}--::::...                    ${NC}"
echo -e "${RED}       .::----==${GRAY}*@@@@@@@@@@${BLACK}%%%%%@@@@@@@@@@@@@%#+-${RED}-::::..                  ${NC}"
echo -e "${RED}      .::-=====${GRAY}*@@@@@@@@@${BLACK}%%%@@@@@@@@@@@@@@@@@@@@@#+${RED}=--::..                ${NC}"
echo -e "${RED}      .:-=++++${GRAY}+@@@@@@@@${BLACK}%%@@@@@@@@@@@@@@@@@@@@@@@@@@%*${RED}=--:.                ${NC}"
echo -e "${RED}      .:-=++*${GRAY}+#@@@@@@${BLACK}%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%=${RED}-:..               ${NC}"
echo -e "${RED}      .:-=++*${GRAY}+#@@@@@${BLACK}%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+${RED}=-:.              ${NC}"
echo -e "${RED}      .:-=+**${GRAY}*#@@@@${BLACK}%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+${RED}=-:.             ${NC}"
echo -e "${RED}      ..:-=+**${GRAY}*@@@@${BLACK}#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%-${RED}-::.            ${NC}"
echo -e "${RED}       .::-=+**${GRAY}%@@${BLACK}%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=${RED}::...           ${NC}"
echo -e "${RED}        .::-=+++${GRAY}%@${BLACK}%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+${RED}::..            ${NC}"
echo -e "${RED}        ..::---==#${BLACK}#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+${RED}::..            ${NC}"
echo -e "${RED}         ..:::::--${BLACK}+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-${RED}::.             ${NC}"
echo -e "${RED}           ......::${BLACK}#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#${RED}...              ${NC}"
echo -e "${RED}               ....:${BLACK}%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${RED}:                 ${NC}"
echo -e "${RED}                  .:=${BLACK}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${RED}-                  ${NC}"
echo -e "${RED}                   ..:${BLACK}#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%${RED}:                   ${NC}"
echo -e "${RED}                       ${BLACK}=%@@@@@@@@@@@@@@@@@@@@@@@@@@%${RED}=                     ${NC}"
echo -e "${RED}                         ${BLACK}=#@@@@@@@@@@@@@@@@@@@@@@#${RED}=                       ${NC}"
echo -e "${RED}                           .${BLACK}=#%@@@@@@@@@@@@@@@#=${RED}:                         ${NC}"
echo -e "${RED}                               .${BLACK}-=+**##**+=-${RED}.                             ${NC}"
echo -e "${PURPLE}    ____           __   ______     ___                    ________    ____${NC}"
echo -e "${PURPLE}   / __ \___  ____/ /  / ____/____/ (_)___  ________     / ____/ /   /  _/${NC}"
echo -e "${PURPLE}  / /_/ / _ \/ __  /  / __/ / ___/ / / __ \/ ___/ _ \   / /   / /    / /  ${NC}"
echo -e "${PURPLE} / _, _/  __/ /_/ /  / /___/ /__/ / / /_/ (__  )  __/  / /___/ /____/ /   ${NC}"
echo -e "${PURPLE}/_/ |_|\___/\__,_/  /_____/\___/_/_/ .___/____/\___/   \____/_____/___/   ${NC}"
echo -e "${PURPLE}                                  /_/                                     ${NC}"
echo -e "${PURPLE}$CLIVER${NC}"
printf "\n"
}

function logo_short()
{
echo -e "${PURPLE}    ____           __   ______     ___                    ________    ____${NC}"
echo -e "${PURPLE}   / __ \___  ____/ /  / ____/____/ (_)___  ________     / ____/ /   /  _/${NC}"
echo -e "${PURPLE}  / /_/ / _ \/ __  /  / __/ / ___/ / / __ \/ ___/ _ \   / /   / /    / /  ${NC}"
echo -e "${PURPLE} / _, _/  __/ /_/ /  / /___/ /__/ / / /_/ (__  )  __/  / /___/ /____/ /   ${NC}"
echo -e "${PURPLE}/_/ |_|\___/\__,_/  /_____/\___/_/_/ .___/____/\___/   \____/_____/___/   ${NC}"
echo -e "${PURPLE}                                  /_/                                     ${NC}"
echo -e "${PURPLE}$CLIVER${NC}"
}

function check_sudo()
{
SUDO=0
if [ -x "$(command -v sudo)" ];       then SUDO=1
else ERROR="sudo is not installed!"; fi
}

function install_dependencies()
{
if [ -x "$(command -v apk)" ];       then sudo apt install $PACKAGESDEBIANUBUNTU &> /dev/null
elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $PACKAGESDEBIANUBUNTU &> /dev/null
elif [ -x "$(command -v dnf)" ];     then sudo dnf install $PACKAGESFEDORA &> /dev/null
elif [ -x "$(command -v zypper)" ];  then sudo zypper install $PACKAGESSUSE &> /dev/null
elif [ -x "$(command -v emerge)" ];  then sudo emerge --ask $PACKAGESGENTOO &> /dev/null
elif [ -x "$(command -v pacman)" ];  then sudo pacman -S $PACKAGESARCH &> /dev/null
elif [ -x "$(command -v xbps)" ];  then sudo xbps-install -Su $PACKAGESARCH &> /dev/null
else ERROR="Package manager not found!">&2; fi
}

function detect_os()
{
case $(uname -m) in
x86_64)
    ARCH='x64'  #or AMD64 or Intel64 or whatever
    ;;
i*86)
    ARCH='x86'  #or IA32 or Intel32 or whatever
    ;;
*)
    #leave ARCH as-is
	ARCH=unknown
    ;;
esac
if [ -f /etc/os-release ]; then
    #freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    #linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    #For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    #Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    #Older SuSE/etc.
	OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
    #Older Red Hat, CentOS, etc.
	...
else
    #Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi
OSTYPE=$OS" "$VER" "$ARCH
}

function loading()
{
PUT(){ echo -en "\033[${1};${2}H";}  
DRAW(){ echo -en "\033%";echo -en "\033(0";}         
WRITE(){ echo -en "\033(B";}  
HIDECURSOR(){ echo -en "\033[?25l";} 
NORM(){ echo -en "\033[?12l\033[?25h";}
function showBar {
        percDone=$(echo 'scale=2;'$1/$2*100 | bc)
        halfDone=$(echo $percDone/2 | bc)
        barLen=$(echo ${percDone%'.00'})
        halfDone=`expr $halfDone + 6`
        tput bold
        PUT 35 $halfDone;  echo -e "\033[7m \033[0m"
		echo -e ""
        tput sgr0
        }
clear
logo
HIDECURSOR                                                                                    
DRAW
echo -e "     PLEASE WAIT WHILE "$TASK" IS IN PROGRESS"
echo -e "    lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk"  
echo -e "    x                                                   x" 
echo -e "    mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj"
WRITE             
for (( i=0; i<=50; i++ ))  
do
    showBar $i 50 
    sleep .2
done
PUT 10 12                                           
echo -e ""                                        
NORM
}

function install()
{
case "$INSTALLVERSION" in
  dev)
  	#install dev version
	APPNAMELONG="Red Eclipse Dev"
	APPCOMMENT="A free, casual arena shooter"
	APPEXEC=redeclipse.sh
	INSTALLPREFIX=dev
	INSTALLAPATHPREFIX=$INSTALLDIRDEV
	INSTALLAPATHPREFIXBASE=/base
	INSTALLAPATHPREFIXICON=$INSTALLAPATHPREFIX
	TERMINALSTAT=false
    cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRDEV" &> /dev/null
	$EXECSUDO mkdir "$DIRDEV" &> /dev/null
	cd "$DIRDEV" &> /dev/null
    $EXECSUDO git clone --recurse-submodules $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO make -C src install &> /dev/null
	desktoplink
    ;;
  stable)	
  	#install stable version
	APPNAMELONG="Red Eclipse"
	APPCOMMENT="A free, casual arena shooter"
  	APPEXEC=redeclipse.sh
  	INSTALLPREFIX=stable
	INSTALLAPATHPREFIX=$INSTALLDIRSTABLE
	INSTALLAPATHPREFIXBASE=/base
	INSTALLAPATHPREFIXICON=$INSTALLAPATHPREFIX
	TERMINALSTAT=false
	cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRSTABLE" &> /dev/null
    $EXECSUDO mkdir "$DIRSTABLE" &> /dev/null
	cd "$DIRSTABLE" &> /dev/null	
    $EXECSUDO git clone --recurse-submodules -b $VERSTABLE --single-branch $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO make -C src install &> /dev/null
	desktoplink
    ;;
  cli)
  	#install cli
	APPNAMELONG="Red Eclipse CLI"
	APPCOMMENT="A CLI to maintain your Red Eclipse installs"
	APPEXEC=redeclipse_cli.sh
	INSTALLPREFIX=cli
	INSTALLAPATHPREFIXBASE=
	TERMINALSTAT=true
	suspend_sudo
	$EXECSUDO cp "$SCRIPTDIRPATH/$SCRIPTNAME" "$INSTALLDIR/$SCRIPTNAME" &> /dev/null
	$EXECSUDO cp -l "$INSTALLDIR/$SCRIPTNAME" "/usr/local/bin/$SCRIPTNAMESHORT" &> /dev/null
	if [[ $DEVINSTALLED = 1 ]]; then
		INSTALLAPATHPREFIX=$INSTALLDIR
		INSTALLAPATHPREFIXICON=$INSTALLDIRDEV
	fi
	if [[ $STABLEINSTALLED = 1 ]]; then
		INSTALLAPATHPREFIX=$INSTALLDIR
		INSTALLAPATHPREFIXICON=$INSTALLDIRSTABLE
	fi
	desktoplink
    ;;
  *)
  	#install both versions
	APPNAMELONG="Red Eclipse Dev"
	APPCOMMENT="A free, casual arena shooter"
	APPEXEC=redeclipse.sh
	INSTALLPREFIX=dev
	INSTALLAPATHPREFIX=$INSTALLDIRDEV
	INSTALLAPATHPREFIXBASE=/base
	INSTALLAPATHPREFIXICON=$INSTALLAPATHPREFIX
	TERMINALSTAT=false
    cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRDEV" &> /dev/null
	$EXECSUDO mkdir "$DIRDEV" &> /dev/null
	cd "$DIRDEV" &> /dev/null
    $EXECSUDO git clone --recurse-submodules $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO make -C src install &> /dev/null
	desktoplink
	APPNAMELONG="Red Eclipse"
	APPCOMMENT="A free, casual arena shooter"
	APPEXEC=redeclipse.sh
	INSTALLPREFIX=stable
	INSTALLAPATHPREFIX=$INSTALLDIRSTABLE
	INSTALLAPATHPREFIXBASE=/base
	INSTALLAPATHPREFIXICON=$INSTALLAPATHPREFIX
	TERMINALSTAT=false
	cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRSTABLE" &> /dev/null
	$EXECSUDO mkdir "$DIRSTABLE" &> /dev/null
	cd "$DIRSTABLE" &> /dev/null
	$EXECSUDO git clone --recurse-submodules -b $VERSTABLE --single-branch $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO make -C src install &> /dev/null
	desktoplink
    ;;
esac
}

function install_server()
{
case "$INSTALLVERSION" in
  dev)
  	#install dev version
    cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRDEVSERVER" &> /dev/null
	$EXECSUDO mkdir "$DIRDEVSERVER" &> /dev/null
	cd "$DIRDEVSERVER" &> /dev/null
    $EXECSUDO git clone -b $DEVELOPMENT $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO git submodule init data/maps &> /dev/null
	$EXECSUDO git pull &> /dev/null
	$EXECSUDO git submodule update &> /dev/null
	$EXECSUDO make -C src/ server install-server &> /dev/null
    ;;
  stable)
  	#install stable version
	cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRSTABLESERVER" &> /dev/null
    $EXECSUDO mkdir "$DIRSTABLESERVER" &> /dev/null
	cd "$DIRSTABLESERVER" &> /dev/null
    $EXECSUDO git clone -b $VERSTABLE $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO git submodule init data/maps &> /dev/null
	$EXECSUDO git pull &> /dev/null
	$EXECSUDO git submodule update &> /dev/null
	$EXECSUDO make -C src/ server install-server &> /dev/null
    ;;
  *)
  	#install both versions
    cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRDEVSERVER" &> /dev/null
	$EXECSUDO mkdir "$DIRDEVSERVER" &> /dev/null
	cd "$DIRDEVSERVER" &> /dev/null
    $EXECSUDO git clone -b $DEVELOPMENT $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO git submodule init data/maps &> /dev/null
	$EXECSUDO git pull &> /dev/null
	$EXECSUDO git submodule update &> /dev/null
	$EXECSUDO make -C src/ server install-server &> /dev/null
	cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRSTABLESERVER" &> /dev/null
	$EXECSUDO mkdir "$DIRSTABLESERVER" &> /dev/null
	cd "$DIRSTABLESERVER" &> /dev/null
	$EXECSUDO git clone -b $VERSTABLE $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO git submodule init data/maps &> /dev/null
	$EXECSUDO git pull &> /dev/null
	$EXECSUDO git submodule update &> /dev/null
	$EXECSUDO make -C src/ server install-server &> /dev/null
    ;;
esac
}

function desktoplink()
{
APPNAME=redeclipse
cd /home/$PUSER/.local/share/applications &> /dev/null
$EXECSUDO rm $APPNAME-$INSTALLPREFIX.desktop &> /dev/null
APPLINK=$APPNAME-$INSTALLPREFIX.desktop
echo -e "[Desktop Entry]" >$APPLINK
echo -e "Categories=Game;" >>$APPLINK
echo -e "Comment=$APPCOMMENT" >>$APPLINK
echo -e "Exec=/bin/bash "$INSTALLAPATHPREFIX$INSTALLAPATHPREFIXBASE/$APPEXEC"" >>$APPLINK
echo -e "Icon=$INSTALLAPATHPREFIXICON/base/data/textures/icon.png" >>$APPLINK
echo -e "Name=$APPNAMELONG" >>$APPLINK
echo -e "Path=$INSTALLAPATHPREFIX$INSTALLAPATHPREFIXBASE" >>$APPLINK
echo -e "StartupNotify=true" >>$APPLINK
echo -e "Terminal=$TERMINALSTAT" >>$APPLINK
echo -e "Type=Application" >>$APPLINK
}

function uninstall()
{
APPNAME=redeclipse
case "$INSTALLVERSION" in
  dev)
  	#uninstall dev version
    cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRDEV" &> /dev/null
	cd /home/$PUSER/.local/share/applications &> /dev/null
	INSTALLPREFIX=dev
	$EXECSUDO rm $APPNAME-$INSTALLPREFIX.desktop &> /dev/null
	INSTALLPREFIX=cli
	$EXECSUDO rm $APPNAME-$INSTALLPREFIX.desktop &> /dev/null
	$EXECSUDO rm /usr/local/bin/$SCRIPTNAMESHORT &> /dev/null
    ;;
  stable)
  	#uninstall stable version
	cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRSTABLE" &> /dev/null
	cd /home/$PUSER/.local/share/applications &> /dev/null
	INSTALLPREFIX=stable
	$EXECSUDO rm $APPNAME-$INSTALLPREFIX.desktop &> /dev/null
	INSTALLPREFIX=cli
	$EXECSUDO rm $APPNAME-$INSTALLPREFIX.desktop &> /dev/null
	$EXECSUDO rm /usr/local/bin/$SCRIPTNAMESHORT &> /dev/null
    ;;
  *)
  	#uninstall both versions
    cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRDEV" &> /dev/null
	$EXECSUDO rm -f -r "$DIRSTABLE" &> /dev/null
	cd /home/$PUSER/.local/share/applications &> /dev/null
	INSTALLPREFIX=dev
	$EXECSUDO rm $APPNAME-$INSTALLPREFIX.desktop &> /dev/null
	INSTALLPREFIX=stable
	$EXECSUDO rm $APPNAME-$INSTALLPREFIX.desktop &> /dev/null
	INSTALLPREFIX=cli
	$EXECSUDO rm $APPNAME-$INSTALLPREFIX.desktop &> /dev/null
	$EXECSUDO rm /usr/local/bin/$SCRIPTNAMESHORT &> /dev/null
    ;;
esac
}

function update()
{
case "$INSTALLVERSION" in
  dev)
  	#update dev version
    cd "$INSTALLDIR"
	cd "$DIRDEV"
    git pull --force git submodule update --remote $GITPATH &> /dev/null
	cd base &> /dev/null
	make -C src install &> /dev/null
    ;;
  stable)
  	#update stable version
    cd "$INSTALLDIR"
	cd "$DIRSTABLE"
    git pull --force git submodule update --remote $GITPATH &> /dev/null
	cd base &> /dev/null
	make -C src install &> /dev/null
    ;;
  *)
  	#update both versions
    cd "$INSTALLDIR"
	cd "$DIRDEV"
    git pull --force git submodule update --remote $GITPATH &> /dev/null
	cd base &> /dev/null
	make -C src install &> /dev/null
	cd "$INSTALLDIR"
	cd "$DIRSTABLE"
    git pull --force git submodule update --remote $GITPATH &> /dev/null
	cd base &> /dev/null
	make -C src install &> /dev/null
    ;;
esac
}

function compile()
{
case "$INSTALLVERSION" in
  dev)
  	#compile dev version
    cd "$INSTALLDIR" &> /dev/null
	cd "$DIRDEV" &> /dev/null
	cd base &> /dev/null
	make -C src install &> /dev/null
    ;;
  stable)
  	#compile stable version
    cd "$INSTALLDIR" &> /dev/null
	cd "$DIRSTABLE" &> /dev/null
	cd base &> /dev/null
	make -C src install &> /dev/null
    ;;
  *)
  	#compile both versions
    cd "$INSTALLDIR" &> /dev/null
	cd "$DIRDEV" &> /dev/null
	cd base &> /dev/null
	make -C src install &> /dev/null
	cd "$INSTALLDIR" &> /dev/null
	cd "$DIRSTABLE" &> /dev/null
	cd base &> /dev/null
	make -C src install &> /dev/null
    ;;
esac
}

function check_install()
{
DEVINSTALLDIR=$INSTALLDIRDEV/$DIRDEV
    cd "$INSTALLDIR" &> /dev/null
	cd "$DIRDEV" &> /dev/null
if [[ -d "base" ]]; then
    DEVINSTALLED=1
	else
	DEVINSTALLED=0
fi
	cd "$INSTALLDIR" &> /dev/null
	cd "$DIRSTABLE" &> /dev/null
STABLEINSTALLDIR=$INSTALLDIRSTABLE/$DIRSTABLE
if [[ -d "base" ]]; then
    STABLEINSTALLED=1
	else
	STABLEINSTALLED=0
fi
}

function status()
{
echo -e "${CYAN}- S T A T U S -${NC}"
if [[ $ERROR = "none" ]] ; then
	echo -e "CLI: ${GREEN}CLI is ready${NC}"
	echo -e "Your OS: ${GREEN}$OSTYPE${NC}"
	echo -e "SUDO: ${GREEN}$SUDOSTATMSG${NC}"
else
	echo -e "CLI: ${REDBLINK}$ERROR${NC}"
	echo -e "Your OS: ${GREEN}$OSTYPE${NC}"
	echo -e "SUDO: ${GREEN}$SUDOSTATMSG${NC}"
fi
}

function install_process()
{
INSTALLTASK=$1
INSTALLTYPE=$2
			TASK="$INSTALLTASK"
			clear
			$INSTALLTYPE & PID=$!
			while [ -d /proc/$PID ]
			do
				loading
				clear
			done
}

function suspend_sudo()
{
sudo -u $PUSER &> /dev/null
}

function main()
{
check_install
clear
logo
status
printf "\n"
echo -e "${YELLOW}- I N S T A L L S -${NC}"
if [[ $STABLEINSTALLED == 0 ]] ; then
	echo -e "Stable Version: ${REDBLINK}Not installed!${NC}"
else
	echo -e "Stable Version: ${RED}Red Eclipse ${PURPLE}$VERSTABLE${NC}"
fi
if [[ $DEVINSTALLED == 0 ]] ; then
 	echo -e "Development Version: ${REDBLINK}Not installed!${NC}"
else
	echo -e "Development Version: ${RED}Red Eclipse ${PURPLE}$VERDEVELOPMENT${NC}"
fi
printf "\n"
}

function cleanup()
{
clear
if [[ $ERROR = "none" ]] ; then
	echo -e "${PURPLE}Red Eclipse${NC} CLI: ${GREEN}CLI exit normal${NC}"
else
	echo -e "${PURPLE}Red Eclipse${NC} CLI: ${REDBLINK}$ERROR${NC}"
fi
#reset cursor
echo -en "\033[?12l\033[?25h"
suspend_sudo
exit
}

function display_help()
{
logo_short
echo "usage: $SCRIPTNAMESHORT [-s <v>|-c <v>|-h]" >&2
printf "\n"
echo -e ' \t '"-s <version>"' \t '"start and update Red Eclipse"
echo -e ' \t '' \t '' \t '"<version> 1 = Red Eclipse $VERSTABLE | 2 = Red Eclipse $VERDEVELOPMENT (Dev)"
echo -e ' \t '"-c <version>"' \t '"compile or recompile Red Eclipse"
echo -e ' \t '' \t '' \t '"<version> 1 = Red Eclipse $VERSTABLE | 2 = Red Eclipse $VERDEVELOPMENT (Dev) | 3 = both"
echo -e ' \t '"-h, --help"' \t '"show this help"
exit 1
}

#quick ui
var1=$2
var2=$3
if [[ "$1" == "-" ]] ; then
	display_help
	exit
fi
if [ -n "$1" ] && [ "$1" != "-" ] ; then
while getopts "sch" opt; do
	case $opt in
    s)
		;;	
	c)
		;;
	h)
		display_help
		exit
		;;
    \?)
		display_help
		exit
		;;
	*)
		display_help
		exit
		;;
	esac
done
fi
#quick start/update
if [[ "$1" = "-s" ]] ; then
	trap cleanup EXIT
	echo $2
	X="$2"
	if [[ "$X" == "" ]] ; then
		X="1"
	fi
	NUM='^[1-2]+$'
 	if ! [[ "$X" =~ $NUM ]] ; then
		ERROR="<version> is not a number form 1 to 2!"
		cleanup
		exit
	fi
	if [[ "$X" -ne 1 ]] && [[ "$X" -ne 2 ]] ; then
		ERROR="<version> is to long and not a number form 1 to 2!"
		cleanup
		exit
	fi
	APPEXEC=redeclipse.sh
	case $X in
		1)
			INSTALLVERSION="stable"
			INSTALLAPATHPREFIX=$INSTALLDIRSTABLE
			INSTALLAPATHPREFIXBASE=/base
			ERROR="Update process was interrupted! Please start the it again!"
			install_process "UPDATE RED ECLIPSE STABLE" update
			ERROR="none"
			bash "$INSTALLAPATHPREFIX$INSTALLAPATHPREFIXBASE/$APPEXEC" &> /dev/null
	    ;;
		2)
			INSTALLVERSION="dev"
			INSTALLAPATHPREFIX=$INSTALLDIRDEV
			INSTALLAPATHPREFIXBASE=/base
			ERROR="Update process was interrupted! Please start the it again!"
			install_process "UPDATE RED ECLIPSE DEV" update
			ERROR="none"
			bash "$INSTALLAPATHPREFIX$INSTALLAPATHPREFIXBASE/$APPEXEC" &> /dev/null
	    ;;
	esac
	ERROR="none"
	cleanup
	exit
fi
#quick compile
if [[ "$1" = "-c" ]] ; then
	trap cleanup EXIT
	echo $2
	X="$2"
	if [[ "$X" == "" ]] ; then
		X="1"
	fi
	NUM='^[1-3]+$'
 	if ! [[ "$X" =~ $NUM ]] ; then
		ERROR="<version> is not a number form 1 to 3!"
		cleanup
		exit
	fi
	if [[ "$X" -ne 1 ]] && [[ "$X" -ne 2 ]] && [[ "$X" -ne 3 ]] ; then
		ERROR="<version> is to long and not a number form 1 to 3!"
		cleanup
		exit
	fi
	case $X in
		1)
			INSTALLVERSION="stable"
			ERROR="Compile process was interrupted! Please start the compile again!"
			install_process "COMPILE RED ECLIPSE STABLE" compile
	    ;;
		2)
			INSTALLVERSION="dev"
			ERROR="Compile process was interrupted! Please start the compile again!"
			install_process "COMPILE RED ECLIPSE DEV" compile
	    ;;
		3)
			INSTALLVERSION="both"
			ERROR="Compile process was interrupted! Please start the compile again!"
			install_process "COMPILE RED ECLIPSE BOTH VERSIONS" compile
	    ;;
	esac
	ERROR="none"
	cleanup
	exit
fi

#trap exit and interrupts
trap cleanup EXIT

#init
autosudo
dofolder
detect_os
check_sudo
check_install

#main menu
main
echo -e "${BLUE}OPTIONS:${NC}"
echo -e "<ENTER> ${GREEN}start/update${NC} <I> ${GREEN}install/reinstall${NC} <U> ${GREEN}uninstall${NC} <C> ${GREEN}compile/recompile${NC} <E> ${GREEN}exit"
read -s -n 1 X; while read -s -n 1 -t .1 y; do x="$x$y"; done
if [[ $X = "i" ]] ; then
	SUDOACTIONMSG="install"
	forcesudo
	clear
	logo
	status
	printf "\n"
	echo -e "${YELLOW}- POSSIBLE INSTALLS -${NC}"
	echo -e "Stable Version: ${RED}Red Eclipse ${PURPLE}$VERSTABLE${NC}"
	echo -e "Development Version: ${RED}Red Eclipse ${PURPLE}$VERDEVELOPMENT${NC}"
	printf "\n"
	echo -e "${PURPLE}Install ${RED}Red Eclipse${NC}"
	echo -e "${YELLOW}Variants:${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Stable${NC} <1> or <ENTER>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Dev${NC} <2>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Both Versions${NC} <3>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Stable - Minimum Server${NC} <4>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Dev - Minimum Server${NC} <5>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Both Versions - Minimum Server${NC} <6>${NC}"
	printf "\n"
	echo -e "${BLUE}OPTIONS:${NC}"
	echo -e "<1> - <6> ${GREEN}select variant${NC} <E> ${GREEN}exit"
	read -s -n 1 X; while read -s -n 1 -t .1 y; do x="$x$y"; done
	if [[ $X = "e" ]] ; then
		ERROR="none"
		clear
		exit
	fi
	if [[ $X == "" ]] ; then
		X="1"
	fi
	case $X in
		1)
			INSTALLVERSION="stable"
			ERROR="Install process was interrupted! Please start the installation again!"
			install_process "INSTALL DEPENDENCIES" install_dependencies
			install_process "INSTALL RED ECLIPSE STABLE" install
	    ;;
		2)
			INSTALLVERSION="dev"
			ERROR="Install process was interrupted! Please start the installation again!"
			install_process "INSTALL DEPENDENCIES" install_dependencies
			install_process "INSTALL RED ECLIPSE DEV" install
	    ;;
		3)
			INSTALLVERSION="both"
			ERROR="Install process was interrupted! Please start the installation again!"
			install_process "INSTALL DEPENDENCIES" install_dependencies
			install_process "INSTALL RED ECLIPSE BOTH VERSIONS" install
	    ;;
		4)
			INSTALLVERSION="stable"
			ERROR="Install process was interrupted! Please start the installation again!"
			install_process "INSTALL DEPENDENCIES" install_dependencies
			install_process "INSTALL RED ECLIPSE STABLE SERVER" install_server
	    ;;
		5)
			INSTALLVERSION="dev"
			ERROR="Install process was interrupted! Please start the installation again!"
			install_process "INSTALL DEPENDENCIES" install_dependencies
			install_process "INSTALL RED ECLIPSE DEV SERVER" install_server
	    ;;
		6)
			INSTALLVERSION="both"
			ERROR="Install process was interrupted! Please start the installation again!"
			install_process "INSTALL DEPENDENCIES" install_dependencies
			install_process "INSTALL RED ECLIPSE BOTH SERVER VERSIONS" install_server
	    ;;
	esac
	ERROR="none"
	clear
	main
	echo -e "${PURPLE}Permanently install ${RED}Red Eclipse CLI${NC}${PURPLE}?${NC}"
	printf "\n"
	echo -e "${BLUE}OPTIONS:${NC}"
	echo -e "<ENTER> ${GREEN}continue without permanently install CLI${NC} <I> ${GREEN}install CLI${NC}"
	read -s -n 1 X; while read -s -n 1 -t .1 y; do x="$x$y"; done
	if [[ $X = "e" ]] ; then
		ERROR="none"
		clear
		exit
	fi
	if [[ $X == "i" ]] ; then
		clear
		INSTALLVERSION="cli"
		ERROR="CLI install process was interrupted! Please start the CLI installation again!"
		install_process "INSTALL RED ECLIPSE CLI PERMANENTLY" install
		ERROR="none"
		clear
		X="su"
	fi
	X="su"
fi
ERROR="none"

#uninstall
if [[ $X = "u" ]] ; then
	SUDOACTIONMSG="uninstall"
	forcesudo
	clear
	main
	echo -e "${PURPLE}Uninstall ${RED}Red Eclipse${NC}"
	echo -e "${YELLOW}Variants:${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Stable${NC} <1> or <ENTER>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Dev${NC} <2>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Both Versions${NC} <3>${NC}"
	printf "\n"
	echo -e "${BLUE}OPTIONS:${NC}"
	echo -e "<1> - <3> ${GREEN}select variant${NC} <E> ${GREEN}exit"
	read -s -n 1 X; while read -s -n 1 -t .1 y; do x="$x$y"; done
	if [[ $X = "e" ]] ; then
		ERROR="none"
		clear
		exit
	fi
	if [[ $X == "" ]] ; then
		X="1"
	fi
	case $X in
		1)
			INSTALLVERSION="stable"
			ERROR="Uninstall process was interrupted! Please start the uninstallation again!"
			install_process "UNINSTALL RED ECLIPSE STABLE" uninstall
	    ;;
		2)
			INSTALLVERSION="dev"
			ERROR="Uninstall process was interrupted! Please start the uninstallation again!"
			install_process "UNINSTALL RED ECLIPSE DEV" uninstall
	    ;;
		3)
			INSTALLVERSION="both"
			ERROR="Uninstall process was interrupted! Please start the uninstallation again!"
			install_process "UNINSTALL RED ECLIPSE BOTH VERSIONS" uninstall
	    ;;
	esac
	ERROR="none"
	clear
	$EXECSUDO "$SCRIPTDIRPATH/$SCRIPTNAME"
fi
ERROR="none"

#compile/recompile
if [[ $X = "c" ]] ; then
	SUDOACTIONMSG="compile/recompile"
	clear
	main
	echo -e "${PURPLE}Compile/Recompile ${RED}Red Eclipse${NC}"
	echo -e "${YELLOW}Variants:${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Stable${NC} <1> or <ENTER>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Dev${NC} <2>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Both Versions${NC} <3>${NC}"
	printf "\n"
	echo -e "${BLUE}OPTIONS:${NC}"
	echo -e "<1> - <3> ${GREEN}select variant${NC} <E> ${GREEN}exit"
	read -s -n 1 X; while read -s -n 1 -t .1 y; do x="$x$y"; done
	if [[ $X = "e" ]] ; then
		ERROR="none"
		clear
		exit
	fi
	if [[ $X == "" ]] ; then
		X="1"
	fi
	case $X in
		1)
			INSTALLVERSION="stable"
			ERROR="Compile process was interrupted! Please start the compile again!"
			install_process "COMPILE RED ECLIPSE STABLE" compile
	    ;;
		2)
			INSTALLVERSION="dev"
			ERROR="Compile process was interrupted! Please start the compile again!"
			install_process "COMPILE RED ECLIPSE DEV" compile
	    ;;
		3)
			INSTALLVERSION="both"
			ERROR="Compile process was interrupted! Please start the compile again!"
			install_process "COMPILE RED ECLIPSE BOTH VERSIONS" compile
	    ;;
	esac
	ERROR="none"
	clear
	$EXECSUDO "$SCRIPTDIRPATH/$SCRIPTNAME"
fi
ERROR="none"

#exit
if [[ $X = "e" ]] ; then
	ERROR="none"
	clear
	exit
fi

#start/update game
if [[ $X == "" ]] ; then
	X="su"
fi
if [[ $X = "su" ]] ; then
	clear
	main
	echo -e "${PURPLE}Start/Update ${RED}Red Eclipse${NC}"
	echo -e "${YELLOW}Variants:${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Stable${NC} <1>  or <ENTER>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Dev${NC} <2>${NC}"
	printf "\n"
	echo -e "${BLUE}OPTIONS:${NC}"
	echo -e "<1> or <ENTER> ${GREEN}start/update Stable${NC} <2> ${GREEN}start/update Dev${NC} <E> ${GREEN}exit"
	read -s -n 1 X; while read -s -n 1 -t .1 y; do x="$x$y"; done
	if [[ $X = "e" ]] ; then
		clear
		ERROR="none"
		exit
	fi
	if [[ $X == "" ]] ; then
		X="1"
	fi
	APPEXEC=redeclipse.sh
	case $X in
		1)
			INSTALLVERSION="stable"
			INSTALLAPATHPREFIX=$INSTALLDIRSTABLE
			INSTALLAPATHPREFIXBASE=/base
			ERROR="Update process was interrupted! Please start the it again!"
			install_process "UPDATE RED ECLIPSE STABLE" update
			ERROR="none"
			bash "$INSTALLAPATHPREFIX$INSTALLAPATHPREFIXBASE/$APPEXEC" &> /dev/null
	    ;;
		2)
			INSTALLVERSION="dev"
			INSTALLAPATHPREFIX=$INSTALLDIRDEV
			INSTALLAPATHPREFIXBASE=/base
			ERROR="Update process was interrupted! Please start the it again!"
			install_process "UPDATE RED ECLIPSE DEV" update
			ERROR="none"
			bash "$INSTALLAPATHPREFIX$INSTALLAPATHPREFIXBASE/$APPEXEC" &> /dev/null
	    ;;
	esac
	clear
fi

#end
ERROR="none"
clear
exit
