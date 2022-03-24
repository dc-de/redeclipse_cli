#!/bin/bash
### Red Eclipse CLI ###
CLIVER='v0.0.2'
GITVER='2'

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
RAWUPDATECLIURL='https://raw.githubusercontent.com/dc-de/redeclipse_cli/main/redeclipse_cli.sh'

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

function updatecli()
{
ERROR="Updating the CLI faild! Try it again!"
clear
TASK="AUTOUPDATE CLI"
TEMPRAWUPDATECLIURL=$RAWUPDATECLIURL
GITVERGIT=$(curl --silent $TEMPRAWUPDATECLIURL | awk -F "=" '/GITVER/ {print $2}')
if [[ $GITVER < $GITVERGIT ]]; then
	rm "$SCRIPTDIRPATH/update$SCRIPTNAME" &> /dev/null
	curl --silent $TEMPRAWUPDATECLIURL --output "$SCRIPTDIRPATH/update$SCRIPTNAME" & PID=$! &> /dev/null
	while [ -d /proc/$PID ]
	do
		loading
		clear
	done
	ERROR="none"
	cp "$SCRIPTDIRPATH/update$SCRIPTNAME" "$SCRIPTDIRPATH/$SCRIPTNAME" && bash "$SCRIPTDIRPATH/$SCRIPTNAME"
	clear
	exit
fi
ERROR="none"
}

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
	echo -e ""
	echo -e "${BLUEBLINK}The script restart with sudo automatically again!${NC}" && sleep 3
	clear
	main
	ERROR="You are not sudo yet! Try it again!"
	echo -e "${PURPLE}You need to be sudo to $SUDOACTIONMSG ${RED}Red Eclipse${NC}${PURPLE}!${NC}"
	echo -e ""
	echo -e "${BLUE}Please enter your password to run the script as sudo again:${NC}"
	sudo bash "$SCRIPTDIRPATH/$SCRIPTNAME"
	ERROR="none"
	clear
	exit
fi
}

function logo()
{
cat <<EOF
                    [38;2;147;32;32m▃[38;2;195;66;66m▂[38;2;188;57;57m▃[38;2;180;43;43m▃[38;2;151;23;23m▄[38;2;135;18;18m▃[0m                        [0m
               [38;2;166;50;50m▃[38;2;229;193;193m▃[38;2;233;213;213;48;2;129;25;25m▅[38;2;239;233;233;48;2;171;49;49m▆[38;2;242;240;240;48;2;207;78;78m▇[38;2;246;246;246;48;2;237;203;203m▇[38;2;250;250;250;48;2;245;245;245m▅[38;2;252;252;252;48;2;249;249;249m▄[38;2;253;253;253;48;2;250;238;238m▇[38;2;254;254;254;48;2;244;154;154m▇[48;2;226;100;100m▆[38;2;254;249;249;48;2;193;58;58m▅[38;2;250;222;222;48;2;154;26;26m▄[38;2;240;164;164;48;2;131;17;17m▂[0m[38;2;160;25;25m▂[0m                    [0m
            [38;2;144;11;11m▃[38;2;227;140;140;48;2;145;20;20m▗[38;2;242;222;222;48;2;176;53;53m▅[38;2;245;243;243;48;2;228;168;168m▇[38;2;250;250;250;48;2;243;243;243m▄[38;2;251;251;251;48;2;245;245;245m▅[38;2;253;253;253;48;2;249;249;249m▄[48;2;250;250;250m▆[38;2;254;254;254;48;2;251;251;251m▆[38;2;255;255;255;48;2;254;254;254m▄▇[0m[7m[38;2;255;255;255m [0m[38;2;254;253;253;48;2;255;255;255m▁[38;2;234;202;201;48;2;254;254;254m▁[38;2;191;77;76m▁[38;2;172;26;27;48;2;254;253;253m▁[38;2;170;26;26;48;2;254;253;252m▁[38;2;243;218;218;48;2;221;104;104m▆[38;2;237;179;178;48;2;151;28;28m▄[0m[38;2;166;32;32m▃[0m                  [0m
          [38;2;133;1;1m▄[38;2;203;34;34;48;2;144;7;7m▗[38;2;246;206;206;48;2;204;63;63m▄[38;2;251;250;250;48;2;244;206;206m▇[38;2;254;254;254;48;2;251;251;251m▄▅[38;2;255;255;255;48;2;253;253;253m▄[48;2;254;254;254m▄▆[38;2;254;254;254;48;2;255;255;255m▁[38;2;201;115;115;48;2;252;249;249m▁[38;2;144;30;30;48;2;251;244;244m▃[38;2;115;20;20;48;2;251;246;246m▅[38;2;88;4;4;48;2;241;220;220m▆[38;2;80;0;1;48;2;220;162;162m▇[38;2;53;0;0;48;2;141;8;8m▆[38;2;47;0;0;48;2;122;0;0m▆[38;2;40;0;0;48;2;108;0;0m▆[38;2;37;0;0;48;2;107;0;0m▆[38;2;34;0;0;48;2;105;0;0m▅[38;2;50;0;0;48;2;144;11;11m▆[38;2;61;0;0;48;2;174;32;30m▆[38;2;43;0;0;48;2;128;8;7m▃[38;2;65;0;0;48;2;115;4;3m▂[0m[38;2;117;7;5m▄[38;2;121;12;10m▁[0m              [0m
       [38;2;136;0;0m▅[38;2;158;0;0;48;2;134;0;0m▄[38;2;164;0;0;48;2;141;0;0m▅[38;2;210;29;29;48;2;166;8;8m▗[38;2;205;37;37;48;2;247;199;199m▘[38;2;254;254;254;48;2;253;253;253m▅[48;2;255;255;255m▘[0m[7m[38;2;255;255;255m   [0m[38;2;246;230;230;48;2;254;254;254m▁[38;2;157;53;53;48;2;249;239;239m▃[38;2;105;18;18;48;2;239;213;213m▆[38;2;65;0;0;48;2;133;12;12m▆[38;2;46;0;0;48;2;80;0;0m▇[38;2;29;0;0;48;2;39;0;0m▂[38;2;28;0;0;48;2;38;0;0m┗[38;2;33;0;0;48;2;28;0;0m┖[38;2;19;0;0;48;2;30;0;0m▃[38;2;15;0;0;48;2;28;0;0m▃[38;2;12;0;0;48;2;22;0;0m▃[38;2;26;0;0;48;2;18;0;0m╸[38;2;12;0;0;48;2;23;0;0m▅[38;2;11;0;0;48;2;22;0;0m▅[38;2;9;0;0;48;2;24;0;0m▅[38;2;13;0;0;48;2;22;0;0m▄[38;2;19;0;0;48;2;36;0;0m▆[38;2;26;0;0;48;2;61;0;0m▆[38;2;38;0;0;48;2;101;4;3m▅[38;2;53;0;0;48;2;111;6;5m▃[38;2;141;9;5;48;2;114;2;2m▗[0m[38;2;139;0;0m▅[0m           [0m
      [7m[38;2;134;0;0m▌[0m[38;2;151;0;0;48;2;167;0;0m▌[38;2;175;0;0;48;2;182;0;0m▍[38;2;202;10;10;48;2;188;2;2m▗[38;2;218;32;32;48;2;246;168;168m▋[38;2;252;247;247;48;2;253;253;253m▏[0m[7m[38;2;255;255;255m   [0m[38;2;254;254;254;48;2;255;255;255m▁[38;2;158;52;52;48;2;248;238;238m▗[38;2;211;148;148;48;2;91;7;7m▘[38;2;48;0;0;48;2;89;0;0m▆[38;2;24;0;0;48;2;37;0;0m⎽[38;2;42;0;0;48;2;33;0;0m▍[38;2;24;0;0;48;2;34;0;0m▄[38;2;18;0;0;48;2;25;0;0m▅[38;2;12;0;0;48;2;18;0;0m╺[38;2;9;0;0;48;2;15;0;0m▗[38;2;12;0;0;48;2;16;0;0m▃[38;2;18;0;0;48;2;13;0;0m◀[38;2;9;0;0m▗[38;2;7;0;0;48;2;10;0;0m▅[48;2;11;0;0m▅[38;2;11;0;0;48;2;6;0;0m▘[38;2;14;0;0;48;2;8;0;0m╶[38;2;5;0;0;48;2;9;0;0m━[38;2;9;0;0;48;2;14;0;0m▆[38;2;14;0;0;48;2;11;0;0m┋[38;2;10;0;0;48;2;15;0;0m▄[38;2;15;0;0;48;2;27;0;0m▆[38;2;21;0;0;48;2;56;0;0m▅[38;2;50;0;0;48;2;126;8;5m▄[38;2;110;7;4;48;2;141;2;1m▂[0m          [0m
      [7m[38;2;133;0;0m▌[0m[38;2;148;0;0;48;2;164;0;0m▍[38;2;196;0;0;48;2;182;0;0m▗[38;2;204;2;2;48;2;219;16;16m▌[38;2;239;55;55;48;2;251;244;244m▌[38;2;254;254;254;48;2;255;255;255m▍[0m[7m[38;2;255;255;255m  [0m[38;2;254;254;254;48;2;255;255;255m▗[38;2;110;1;1;48;2;228;185;185m▗[38;2;128;10;11;48;2;61;0;0m▘[38;2;29;0;0;48;2;44;0;0m▃[38;2;25;0;0;48;2;37;0;0m▃[38;2;28;0;0;48;2;22;0;0m▌[38;2;15;0;0;48;2;27;0;0m▅[38;2;6;0;0;48;2;16;0;0m▄[38;2;8;0;0;48;2;14;0;0m▆[38;2;7;0;0;48;2;11;0;0m▅[48;2;9;0;0m▆[38;2;5;0;0;48;2;7;0;0m╾[38;2;8;0;0;48;2;15;0;0m▇▆[48;2;11;0;0m▅[38;2;9;0;0;48;2;7;0;0m▆[38;2;8;0;0m▅[38;2;7;0;0;48;2;5;0;0m▃[38;2;4;0;0;48;2;7;0;0m▁[38;2;3;0;0;48;2;6;0;0m⎽[38;2;4;0;0;48;2;9;0;0m▆[48;2;6;0;0m▂[38;2;5;0;0;48;2;9;0;0m▆[38;2;4;0;0m▄[38;2;20;0;0;48;2;7;0;0m▝[38;2;81;5;3;48;2;28;0;0m▝[38;2;65;3;2;48;2;135;5;2m▖[0m[38;2;142;0;0m▄[0m        [0m
       [38;2;141;0;0;48;2;161;0;0m▌[38;2;178;0;0;48;2;196;0;0m▍[38;2;217;3;3;48;2;232;16;16m▋[38;2;243;45;45;48;2;251;232;232m▌[38;2;253;253;253;48;2;254;254;254m▎[0m[7m[38;2;255;255;255m  [0m[38;2;135;9;9;48;2;237;207;207m▗[38;2;126;2;2;48;2;64;0;0m▘[38;2;40;0;0;48;2;33;0;0m▚[38;2;22;0;0;48;2;28;0;0m■[38;2;18;0;0;48;2;24;0;0m▗[38;2;15;0;0;48;2;10;0;0m▎[38;2;11;0;0;48;2;7;0;0m╸[38;2;4;0;0m╻[38;2;5;0;0;48;2;8;0;0m▂[38;2;7;0;0;48;2;5;0;0m▖[38;2;8;0;0m▗[38;2;7;0;0;48;2;9;0;0m▋[38;2;10;0;0;48;2;7;0;0m╾[38;2;4;0;0m╲[38;2;7;0;0;48;2;4;0;0m▘[48;2;5;0;0m▲[38;2;8;0;0;48;2;6;0;0m╎[38;2;4;0;0;48;2;5;0;0m▚[38;2;2;0;0;48;2;3;0;0m▂[48;2;5;0;0m▃[38;2;3;0;0;48;2;2;0;0m▶[38;2;2;0;0;48;2;4;0;0m▆[38;2;3;0;0;48;2;1;0;0m▘[38;2;0;0;0;48;2;2;0;0m▅[48;2;1;0;0m▃[38;2;8;0;0m▝[38;2;60;3;2;48;2;20;0;0m▝[38;2;74;7;3;48;2;162;4;1m▖[0m[7m[38;2;140;0;0m▝[0m       [0m
       [38;2;138;0;0m▝[38;2;144;0;0;48;2;169;0;0m▅[38;2;171;0;0;48;2;203;3;3m▖[38;2;247;132;132;48;2;231;26;26m▝[38;2;249;197;197;48;2;252;249;249m▏[38;2;254;254;254;48;2;255;255;255m▖[38;2;254;253;253;48;2;228;182;183m▉[38;2;181;72;72;48;2;97;0;0m▎[38;2;57;0;0;48;2;39;0;0m▘[38;2;23;0;0;48;2;30;0;0m▗[38;2;26;0;0;48;2;19;0;0m┹[38;2;12;0;0;48;2;18;0;0m▇[38;2;5;0;0;48;2;9;0;0m■[38;2;6;0;0;48;2;8;0;0m▂[38;2;3;0;0;48;2;6;0;0m╏[38;2;7;0;0;48;2;5;0;0m▅[38;2;10;0;0;48;2;7;0;0m⎺[38;2;2;0;0;48;2;4;0;0m╻[38;2;5;0;0;48;2;9;0;0m▅[38;2;4;0;0;48;2;8;0;0m▂[38;2;3;0;0;48;2;6;0;0m▗[48;2;5;0;0m▄[38;2;1;0;0;48;2;4;0;0m▄[48;2;2;0;0m▗[48;2;3;0;0m▆[38;2;0;0;0;48;2;1;0;0m▗▃▅▆[38;2;1;0;0;48;2;0;0;0m·[0m[7m[38;2;0;0;0m   [0m[38;2;10;0;0;48;2;1;0;0m▝[38;2;28;0;0;48;2;94;12;4m▋[0m        [0m
        [38;2;137;0;0m▝[38;2;172;0;0;48;2;147;0;0m▝[38;2;162;2;2;48;2;204;11;11m▄[38;2;250;233;233;48;2;216;55;55m▝[38;2;249;212;212;48;2;253;252;252m▁[38;2;252;247;247;48;2;166;24;24m▊[38;2;110;0;0;48;2;57;0;0m▍[38;2;27;0;0;48;2;39;0;0m▗[38;2;28;0;0;48;2;23;0;0m▚[38;2;17;0;0;48;2;25;0;0m▅[38;2;16;0;0;48;2;12;0;0m╸[38;2;10;0;0;48;2;7;0;0m▘[38;2;5;0;0m▂▌[38;2;10;0;0;48;2;6;0;0m╸[38;2;6;0;0;48;2;12;0;0m▇[38;2;7;0;0;48;2;11;0;0m▅[38;2;9;0;0;48;2;5;0;0m▘[38;2;6;0;0;48;2;4;0;0m▘[38;2;3;0;0;48;2;2;0;0m▎[38;2;2;0;0;48;2;1;0;0m┸[38;2;1;0;0;48;2;0;0;0m▘[38;2;0;0;0;48;2;1;0;0m▇[0m[7m[38;2;0;0;0m         [0m[38;2;0;0;0;48;2;2;0;0m▉[38;2;11;0;0;48;2;31;0;0m▋[0m[38;2;62;12;4m▏[0m       [0m
           [38;2;162;16;16m▝[38;2;246;189;189;48;2;180;31;31m▝[38;2;242;190;190;48;2;159;21;21m▊[38;2;101;0;0;48;2;54;0;0m▍[38;2;35;0;0;48;2;25;0;0m▌[38;2;14;0;0;48;2;22;0;0m▂[38;2;20;0;0;48;2;13;0;0m▏[38;2;6;0;0;48;2;10;0;0m▗[38;2;8;0;0;48;2;6;0;0m▍[38;2;7;0;0;48;2;5;0;0m▋[38;2;6;0;0;48;2;4;0;0m▄[38;2;7;0;0;48;2;11;0;0m▄[38;2;9;0;0;48;2;4;0;0m▋[38;2;2;0;0;48;2;5;0;0m╺[48;2;4;0;0m▆[48;2;1;0;0m▍[38;2;0;0;0m▄[0m[7m[38;2;0;0;0m            [0m[38;2;0;0;0;48;2;2;0;0m▉[38;2;8;0;0;48;2;25;0;0m▋[0m        [0m
             [7m[38;2;164;22;23m▅[0m[38;2;115;2;2;48;2;66;0;0m▌[38;2;25;0;0;48;2;35;0;0m╲[38;2;9;0;0;48;2;18;0;0m┗[38;2;17;0;0;48;2;13;0;0m▍[38;2;13;0;0;48;2;9;0;0m▖[38;2;7;0;0m▆[38;2;10;0;0;48;2;5;0;0m⎺[38;2;6;0;0;48;2;3;0;0m▆[38;2;9;0;0;48;2;6;0;0m╻[38;2;5;0;0;48;2;3;0;0m▎[38;2;2;0;0m▄[38;2;3;0;0;48;2;1;0;0m▘[38;2;1;0;0;48;2;0;0;0m▘[0m[7m[38;2;0;0;0m             [0m[38;2;0;0;0;48;2;3;0;0m▋[38;2;14;0;0;48;2;64;12;3m▋[0m        [0m
              [7m[38;2;84;1;1m▍[0m[38;2;76;0;0;48;2;38;0;0m▖[38;2;10;0;0;48;2;17;0;0m┒[38;2;19;0;0;48;2;12;0;0m╸[38;2;9;0;0;48;2;13;0;0m▖[38;2;12;0;0;48;2;9;0;0m▌[38;2;8;0;0;48;2;5;0;0m▄[38;2;6;0;0;48;2;3;0;0m▇[38;2;5;0;0m▎[38;2;3;0;0;48;2;2;0;0m╱[38;2;1;0;0m▅[48;2;0;0;0m▘[0m[7m[38;2;0;0;0m             [0m[38;2;0;0;0;48;2;1;0;0m▉[38;2;23;3;1;48;2;5;0;0m▗[0m[38;2;77;18;5m╹[0m        [0m
               [38;2;91;2;2;48;2;69;0;0m▘[38;2;59;0;0;48;2;27;0;0m▖[38;2;17;0;0;48;2;13;0;0m▍[38;2;11;0;0;48;2;8;0;0m▖[38;2;9;0;0;48;2;7;0;0m▚[38;2;6;0;0m▚[38;2;4;0;0;48;2;9;0;0m▇[38;2;2;0;0;48;2;6;0;0m▃[38;2;4;0;0;48;2;2;0;0m╸[38;2;0;0;0;48;2;1;0;0m▁[0m[7m[38;2;0;0;0m             [0m[38;2;1;0;0;48;2;0;0;0m▗[38;2;25;5;2;48;2;3;0;0m▗[0m[7m[38;2;21;1;0m╱[0m         [0m
                [7m[38;2;49;1;1m▄[0m[38;2;45;1;2;48;2;27;1;1m┑[38;2;25;0;0;48;2;12;0;0m▖[38;2;8;0;0;48;2;6;0;0m▖[38;2;4;0;0m▃[38;2;5;0;0;48;2;3;0;0m▘[38;2;1;0;0;48;2;2;0;0m▂[48;2;0;0;0m▋[0m[7m[38;2;0;0;0m [0m[38;2;1;0;0;48;2;0;0;0m▘[0m[7m[38;2;0;0;0m           [0m[38;2;5;0;0;48;2;0;0;0m▗[38;2;29;8;2;48;2;5;0;0m▄[0m           [0m
                  [7m[38;2;28;2;3m▄[0m[38;2;34;2;3;48;2;17;1;1m╸[38;2;22;1;1;48;2;6;0;0m▃[38;2;8;0;0;48;2;2;0;0m▂[38;2;2;0;0;48;2;0;0;0m▂[0m[7m[38;2;0;0;0m           [0m[38;2;3;0;0;48;2;0;0;0m▁[38;2;29;10;3;48;2;2;0;0m▁[0m[7m[38;2;4;0;0m▄[38;2;27;8;2m▄[0m            [0m
                     [7m[38;2;20;3;3m▄[0m[38;2;29;7;5;48;2;7;0;0m╾[0m[7m[38;2;8;1;0m⎽[0m[38;2;27;8;4;48;2;3;0;0m▂[38;2;23;6;4;48;2;2;0;0m▁[38;2;8;0;0;48;2;0;0;0m▂[38;2;6;0;0m▂[38;2;5;0;0m▂[38;2;6;0;0m▂[38;2;32;12;6;48;2;1;0;0m▁[38;2;30;11;4m▂[0m[7m[38;2;2;0;0m▃[0m[38;2;38;14;5;48;2;4;0;0m╼[0m[7m[38;2;20;6;2m▄[0m               [0m
                          [7m[38;2;42;16;7m▇[38;2;34;14;5m▆▆[38;2;48;19;8m▇[0m                    [0m
[0m  [38;2;250;250;250m▁[38;2;251;251;251m▁▁[0m [38;2;217;217;217m▁[38;2;251;251;251m▁▁▁[38;2;250;250;250m▁[0m  [38;2;213;213;213m▁[38;2;251;251;251m▁▁[38;2;172;172;172m▁[7m[38;2;215;215;215m▍[0m[38;2;244;244;244;48;2;138;138;138m▉[0m     [38;2;250;250;250m▁[38;2;251;251;251m▁▁▁[38;2;220;220;220m▁[0m  [38;2;250;250;250m▁[38;2;251;251;251m▁▁▁[0m [7m[38;2;206;206;206m▌[0m[38;2;241;241;241;48;2;162;162;162m▇[0m [38;2;238;238;238;48;2;136;136;136m┻[0m[38;2;192;192;192m▘[0m [38;2;249;249;249m▁[38;2;251;251;251m▁▁▁[38;2;229;229;229m▁[0m  [38;2;250;250;250m▁[38;2;252;252;252m▁▁▁▁[0m  [38;2;248;248;248m▁[38;2;251;251;251m▁▁▁[38;2;235;235;235m▁[0m     [38;2;119;0;0m▆[7m[38;2;114;0;0m▗[38;2;118;0;0m▃▃[38;2;103;0;0m▃[0m [38;2;65;0;0;48;2;122;0;0m▘[0m[38;2;106;0;0m▋   [0m [7m[38;2;121;0;0m▘[0m[38;2;108;0;0m▋[0m
 [38;2;251;251;251;48;2;193;193;193m▇[0m[7m[38;2;215;215;215m▗[38;2;251;251;251m▄[38;2;184;184;184m▄[38;2;211;211;211m▍[0m[38;2;149;149;149;48;2;254;254;254m▗[0m[7m[38;2;211;211;211m─[38;2;232;232;232m─[38;2;235;235;235m─[38;2;255;255;255m [0m[38;2;203;203;203m▌[7m[38;2;226;226;226m▌[0m[38;2;161;161;161;48;2;254;254;254m▗[0m[7m[38;2;251;251;251m▄▄[0m [38;2;179;179;179;48;2;252;252;252m▏[0m[38;2;211;211;211m▌   [0m [38;2;182;182;182;48;2;254;254;254m▘[0m[7m[38;2;221;221;221m┎[38;2;232;232;232m──[38;2;246;246;246m╴[0m[38;2;249;249;249;48;2;156;156;156m▉[0m [38;2;170;170;170;48;2;254;254;254m▘[0m[7m[38;2;232;232;232m▗[38;2;251;251;251m▄▄[38;2;206;206;206m▄[0m [38;2;148;148;148;48;2;248;248;248m▏[0m[38;2;227;227;227m▌[7m[38;2;214;214;214m▌[0m[38;2;251;251;251;48;2;174;174;174m▉[0m [38;2;153;153;153;48;2;254;254;254m▘[0m[7m[38;2;238;238;238m▗[38;2;251;251;251m▄▄[38;2;252;252;252m▖[0m[38;2;253;253;253;48;2;185;185;185m▉[0m [38;2;141;141;141;48;2;253;253;253m▘[0m[7m[38;2;244;244;244m╶[38;2;232;232;232m───[38;2;191;191;191m╼[0m [38;2;129;129;129;48;2;252;252;252m▘[0m[7m[38;2;244;244;244m▗[38;2;232;232;232m──[38;2;241;241;241m╴[0m[38;2;254;254;254;48;2;208;208;208m▉[0m    [7m[38;2;102;0;0m▌[0m[38;2;127;0;0;48;2;95;0;0m▉[0m    [7m[38;2;112;0;0m▋[0m[38;2;127;0;0;48;2;100;0;0m▉[0m    [7m[38;2;109;0;0m▋[0m[38;2;127;0;0;48;2;105;0;0m▉[0m [0m
[7m[38;2;225;225;225m▍[0m[38;2;132;132;132;48;2;250;250;250m▗[0m   [38;2;206;206;206;48;2;254;254;254m▏[0m[7m[38;2;247;247;247m▝[38;2;226;226;226m━[38;2;235;235;235m━[38;2;255;255;255m▆[38;2;237;237;237m▆[38;2;133;133;133m▉[0m[38;2;195;195;195;48;2;253;253;253m▏[0m[7m[38;2;248;248;248m▝[0m[38;2;244;244;244m▄▄[7m[38;2;238;238;238m▘[0m[38;2;146;146;146;48;2;253;253;253m▗[0m    [7m[38;2;231;231;231m▌[0m[38;2;249;249;249;48;2;255;255;255m╺[0m[38;2;244;244;244m▄[7m[38;2;235;235;235m━[38;2;231;231;231m━[38;2;255;255;255m▆[38;2;137;137;137m▆[38;2;225;225;225m▌[0m[38;2;253;253;253;48;2;255;255;255m╺[0m[38;2;244;244;244m▄▄▄[38;2;177;177;177m▖[7m[38;2;220;220;220m▌[0m[38;2;250;250;250;48;2;161;161;161m▉[0m [38;2;152;152;152;48;2;248;248;248m▏[0m[38;2;225;225;225m▌[7m[38;2;216;216;216m▌[0m[38;2;251;251;251;48;2;169;169;169m▉[0m [38;2;243;243;243m▄[38;2;244;244;244m▄[38;2;170;170;170;48;2;254;254;254m▘[0m[38;2;223;223;223m▌[38;2;242;242;242m▗[7m[38;2;229;229;229m━[38;2;234;234;234m━━━[0m[38;2;216;216;216;48;2;254;254;254m▏[0m[38;2;227;227;227m▌[7m[38;2;202;202;202m▌[38;2;255;255;255m [0m[38;2;244;244;244m▄[7m[38;2;235;235;235m━[38;2;234;234;234m━[38;2;255;255;255m▆[38;2;164;164;164m▆[0m    [38;2;82;0;0;48;2;127;0;0m▘[0m[7m[38;2;126;0;0m▝[0m[38;2;122;0;0m▄▄[38;2;112;0;0m▄[0m [38;2;77;0;0;48;2;127;0;0m▘[0m[7m[38;2;126;0;0m▝[0m[38;2;122;0;0m▄▄[38;2;114;0;0m▄[0m [38;2;72;0;0;48;2;126;0;0m▘[0m[38;2;110;0;0m▋ [0m
[7m[38;2;229;229;229m▇[38;2;152;152;152m▇[0m   [7m[38;2;245;245;245m▇[38;2;255;255;255m▇▇▇[0m   [7m[38;2;243;243;243m▇[38;2;255;255;255m▇▇▇[38;2;254;254;254m▇[0m      [7m[38;2;254;254;254m▇[38;2;255;255;255m▇▇[38;2;190;190;190m▇[0m   [7m[38;2;254;254;254m▇[38;2;255;255;255m▇▇▇[0m [7m[38;2;200;200;200m▇[38;2;182;182;182m▇[0m [7m[38;2;255;255;255m▇[0m [38;2;148;148;148;48;2;240;240;240m▏[0m[38;2;218;218;218m▌[7m[38;2;178;178;178m▇[38;2;255;255;255m▇▇[38;2;223;223;223m▇[0m [7m[38;2;190;190;190m▇[38;2;254;254;254m▇▇▇▇[38;2;224;224;224m▇[0m  [7m[38;2;254;254;254m▇[38;2;255;255;255m▇▇[38;2;218;218;218m▇[0m      [7m[38;2;113;0;0m▇[38;2;128;0;0m▇▇▇[38;2;98;0;0m▇[0m [7m[38;2;110;0;0m▇[38;2;128;0;0m▇▇▇[38;2;100;0;0m▇[0m [7m[38;2;128;0;0m▇[0m  [0m
EOF
echo -e "${RED}$CLIVER${NC}"
echo -e ""
}

function logo_short()
{
cat <<EOF
[0m  [38;2;250;250;250m▁[38;2;251;251;251m▁▁[0m [38;2;217;217;217m▁[38;2;251;251;251m▁▁▁[38;2;250;250;250m▁[0m  [38;2;213;213;213m▁[38;2;251;251;251m▁▁[38;2;172;172;172m▁[7m[38;2;215;215;215m▍[0m[38;2;244;244;244;48;2;138;138;138m▉[0m     [38;2;250;250;250m▁[38;2;251;251;251m▁▁▁[38;2;220;220;220m▁[0m  [38;2;250;250;250m▁[38;2;251;251;251m▁▁▁[0m [7m[38;2;206;206;206m▌[0m[38;2;241;241;241;48;2;162;162;162m▇[0m [38;2;238;238;238;48;2;136;136;136m┻[0m[38;2;192;192;192m▘[0m [38;2;249;249;249m▁[38;2;251;251;251m▁▁▁[38;2;229;229;229m▁[0m  [38;2;250;250;250m▁[38;2;252;252;252m▁▁▁▁[0m  [38;2;248;248;248m▁[38;2;251;251;251m▁▁▁[38;2;235;235;235m▁[0m     [38;2;119;0;0m▆[7m[38;2;114;0;0m▗[38;2;118;0;0m▃▃[38;2;103;0;0m▃[0m [38;2;65;0;0;48;2;122;0;0m▘[0m[38;2;106;0;0m▋   [0m [7m[38;2;121;0;0m▘[0m[38;2;108;0;0m▋[0m
 [38;2;251;251;251;48;2;193;193;193m▇[0m[7m[38;2;215;215;215m▗[38;2;251;251;251m▄[38;2;184;184;184m▄[38;2;211;211;211m▍[0m[38;2;149;149;149;48;2;254;254;254m▗[0m[7m[38;2;211;211;211m─[38;2;232;232;232m─[38;2;235;235;235m─[38;2;255;255;255m [0m[38;2;203;203;203m▌[7m[38;2;226;226;226m▌[0m[38;2;161;161;161;48;2;254;254;254m▗[0m[7m[38;2;251;251;251m▄▄[0m [38;2;179;179;179;48;2;252;252;252m▏[0m[38;2;211;211;211m▌   [0m [38;2;182;182;182;48;2;254;254;254m▘[0m[7m[38;2;221;221;221m┎[38;2;232;232;232m──[38;2;246;246;246m╴[0m[38;2;249;249;249;48;2;156;156;156m▉[0m [38;2;170;170;170;48;2;254;254;254m▘[0m[7m[38;2;232;232;232m▗[38;2;251;251;251m▄▄[38;2;206;206;206m▄[0m [38;2;148;148;148;48;2;248;248;248m▏[0m[38;2;227;227;227m▌[7m[38;2;214;214;214m▌[0m[38;2;251;251;251;48;2;174;174;174m▉[0m [38;2;153;153;153;48;2;254;254;254m▘[0m[7m[38;2;238;238;238m▗[38;2;251;251;251m▄▄[38;2;252;252;252m▖[0m[38;2;253;253;253;48;2;185;185;185m▉[0m [38;2;141;141;141;48;2;253;253;253m▘[0m[7m[38;2;244;244;244m╶[38;2;232;232;232m───[38;2;191;191;191m╼[0m [38;2;129;129;129;48;2;252;252;252m▘[0m[7m[38;2;244;244;244m▗[38;2;232;232;232m──[38;2;241;241;241m╴[0m[38;2;254;254;254;48;2;208;208;208m▉[0m    [7m[38;2;102;0;0m▌[0m[38;2;127;0;0;48;2;95;0;0m▉[0m    [7m[38;2;112;0;0m▋[0m[38;2;127;0;0;48;2;100;0;0m▉[0m    [7m[38;2;109;0;0m▋[0m[38;2;127;0;0;48;2;105;0;0m▉[0m [0m
[7m[38;2;225;225;225m▍[0m[38;2;132;132;132;48;2;250;250;250m▗[0m   [38;2;206;206;206;48;2;254;254;254m▏[0m[7m[38;2;247;247;247m▝[38;2;226;226;226m━[38;2;235;235;235m━[38;2;255;255;255m▆[38;2;237;237;237m▆[38;2;133;133;133m▉[0m[38;2;195;195;195;48;2;253;253;253m▏[0m[7m[38;2;248;248;248m▝[0m[38;2;244;244;244m▄▄[7m[38;2;238;238;238m▘[0m[38;2;146;146;146;48;2;253;253;253m▗[0m    [7m[38;2;231;231;231m▌[0m[38;2;249;249;249;48;2;255;255;255m╺[0m[38;2;244;244;244m▄[7m[38;2;235;235;235m━[38;2;231;231;231m━[38;2;255;255;255m▆[38;2;137;137;137m▆[38;2;225;225;225m▌[0m[38;2;253;253;253;48;2;255;255;255m╺[0m[38;2;244;244;244m▄▄▄[38;2;177;177;177m▖[7m[38;2;220;220;220m▌[0m[38;2;250;250;250;48;2;161;161;161m▉[0m [38;2;152;152;152;48;2;248;248;248m▏[0m[38;2;225;225;225m▌[7m[38;2;216;216;216m▌[0m[38;2;251;251;251;48;2;169;169;169m▉[0m [38;2;243;243;243m▄[38;2;244;244;244m▄[38;2;170;170;170;48;2;254;254;254m▘[0m[38;2;223;223;223m▌[38;2;242;242;242m▗[7m[38;2;229;229;229m━[38;2;234;234;234m━━━[0m[38;2;216;216;216;48;2;254;254;254m▏[0m[38;2;227;227;227m▌[7m[38;2;202;202;202m▌[38;2;255;255;255m [0m[38;2;244;244;244m▄[7m[38;2;235;235;235m━[38;2;234;234;234m━[38;2;255;255;255m▆[38;2;164;164;164m▆[0m    [38;2;82;0;0;48;2;127;0;0m▘[0m[7m[38;2;126;0;0m▝[0m[38;2;122;0;0m▄▄[38;2;112;0;0m▄[0m [38;2;77;0;0;48;2;127;0;0m▘[0m[7m[38;2;126;0;0m▝[0m[38;2;122;0;0m▄▄[38;2;114;0;0m▄[0m [38;2;72;0;0;48;2;126;0;0m▘[0m[38;2;110;0;0m▋ [0m
[7m[38;2;229;229;229m▇[38;2;152;152;152m▇[0m   [7m[38;2;245;245;245m▇[38;2;255;255;255m▇▇▇[0m   [7m[38;2;243;243;243m▇[38;2;255;255;255m▇▇▇[38;2;254;254;254m▇[0m      [7m[38;2;254;254;254m▇[38;2;255;255;255m▇▇[38;2;190;190;190m▇[0m   [7m[38;2;254;254;254m▇[38;2;255;255;255m▇▇▇[0m [7m[38;2;200;200;200m▇[38;2;182;182;182m▇[0m [7m[38;2;255;255;255m▇[0m [38;2;148;148;148;48;2;240;240;240m▏[0m[38;2;218;218;218m▌[7m[38;2;178;178;178m▇[38;2;255;255;255m▇▇[38;2;223;223;223m▇[0m [7m[38;2;190;190;190m▇[38;2;254;254;254m▇▇▇▇[38;2;224;224;224m▇[0m  [7m[38;2;254;254;254m▇[38;2;255;255;255m▇▇[38;2;218;218;218m▇[0m      [7m[38;2;113;0;0m▇[38;2;128;0;0m▇▇▇[38;2;98;0;0m▇[0m [7m[38;2;110;0;0m▇[38;2;128;0;0m▇▇▇[38;2;100;0;0m▇[0m [7m[38;2;128;0;0m▇[0m  [0m
EOF
echo -e "${RED}$CLIVER${NC}"
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
function showbar {
        percDone=$(echo 'scale=2;'$1/$2*100 | bc)
        halfDone=$(echo $percDone/2 | bc)
        barLen=$(echo ${percDone%'.00'})
        halfDone=`expr $halfDone + 6`
        tput bold
        PUT 27 $halfDone;  echo -e "\033[7m \033[0m"
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
    showbar $i 50 
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
	$EXECSUDO make all -BnC src clean && make all -BnC src install &> /dev/null
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
	$EXECSUDO make all -BnC src clean && make all -BnC src install &> /dev/null
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
	$EXECSUDO make all -BnC src clean && make all -BnC src install &> /dev/null
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
	$EXECSUDO make all -BnC src clean && make all -BnC src install &> /dev/null
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
	$EXECSUDO make all -BnC src clean && make all -BnC src/ server install-server &> /dev/null
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
	$EXECSUDO make all -BnC src clean && make all -BnC src/ server install-server &> /dev/null
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
	$EXECSUDO make all -BnC src clean && make all -BnC src/ server install-server &> /dev/null
	cd "$INSTALLDIR" &> /dev/null
	$EXECSUDO rm -f -r "$DIRSTABLESERVER" &> /dev/null
	$EXECSUDO mkdir "$DIRSTABLESERVER" &> /dev/null
	cd "$DIRSTABLESERVER" &> /dev/null
	$EXECSUDO git clone -b $VERSTABLE $GITPATH &> /dev/null
	cd base &> /dev/null
	$EXECSUDO git submodule init data/maps &> /dev/null
	$EXECSUDO git pull &> /dev/null
	$EXECSUDO git submodule update &> /dev/null
	$EXECSUDO make all -BnC src clean && make all -BnC src/ server install-server &> /dev/null
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
	make -BnC src install &> /dev/null
    ;;
  stable)
  	#update stable version
    cd "$INSTALLDIR"
	cd "$DIRSTABLE"
    git pull --force git submodule update --remote $GITPATH &> /dev/null
	cd base &> /dev/null
	make -BnC src install &> /dev/null
    ;;
  *)
  	#update both versions
    cd "$INSTALLDIR"
	cd "$DIRDEV"
    git pull --force git submodule update --remote $GITPATH &> /dev/null
	cd base &> /dev/null
	make all -BnC src clean && make all -BnC src install &> /dev/null
	cd "$INSTALLDIR"
	cd "$DIRSTABLE"
    git pull --force git submodule update --remote $GITPATH &> /dev/null
	cd base &> /dev/null
	make -BnC src install &> /dev/null
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
	make -BnC src install &> /dev/null
    ;;
  stable)
  	#compile stable version
    cd "$INSTALLDIR" &> /dev/null
	cd "$DIRSTABLE" &> /dev/null
	cd base &> /dev/null
	make -BnC src install &> /dev/null
    ;;
  *)
  	#compile both versions
    cd "$INSTALLDIR" &> /dev/null
	cd "$DIRDEV" &> /dev/null
	cd base &> /dev/null
	make -BnC src install &> /dev/null
	cd "$INSTALLDIR" &> /dev/null
	cd "$DIRSTABLE" &> /dev/null
	cd base &> /dev/null
	make -BnC src install &> /dev/null
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
echo -e ""
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
echo -e ""
}

function cleanup()
{
clear
if [[ $ERROR = "none" ]] ; then
	echo -e "${PURPLE}Red Eclipse${NC} CLI: ${GREEN}CLI exit normal${NC}"
else
	echo -e "${PURPLE}Red Eclipse${NC} CLI: ${REDBLINK}$ERROR${NC}"
fi
#clean update CLI
rm "$SCRIPTDIRPATH/update$SCRIPTNAME" &> /dev/null
#reset cursor
echo -en "\033[?12l\033[?25h"
suspend_sudo
exit
}

function display_help()
{
logo_short
echo "usage: $SCRIPTNAMESHORT [-s <v>|-c <v>|-h]" >&2
echo -e ""
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

#update CLI
updatecli
#clean update CLI
rm "$SCRIPTDIRPATH/update$SCRIPTNAME" &> /dev/null

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
	echo -e ""
	echo -e "${YELLOW}- POSSIBLE INSTALLS -${NC}"
	echo -e "Stable Version: ${RED}Red Eclipse ${PURPLE}$VERSTABLE${NC}"
	echo -e "Development Version: ${RED}Red Eclipse ${PURPLE}$VERDEVELOPMENT${NC}"
	echo -e ""
	echo -e "${PURPLE}Install ${RED}Red Eclipse${NC}"
	echo -e "${YELLOW}Variants:${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Stable${NC} <1> or <ENTER>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Dev${NC} <2>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Both Versions${NC} <3>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Stable - Minimum Server${NC} <4>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Dev - Minimum Server${NC} <5>${NC}"
	echo -e "${RED}Red Eclipse ${GREEN}Both Versions - Minimum Server${NC} <6>${NC}"
	echo -e ""
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
	echo -e ""
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
	echo -e ""
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
	echo -e ""
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
	"$SCRIPTDIRPATH/$SCRIPTNAME"
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
	echo -e ""
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
