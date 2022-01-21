#!/bin/bash

RED="$(printf '\033[31m')"  
GREEN="$(printf '\033[32m')"  
ORANGE="$(printf '\033[33m')"  
BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  
CYAN="$(printf '\033[36m')"  
WHITE="$(printf '\033[37m')" 
BLACK="$(printf '\033[30m')"
# bg
REDBG="$(printf '\033[41m')"  
GREENBG="$(printf '\033[42m')"  
ORANGEBG="$(printf '\033[43m')"  
BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  
CYANBG="$(printf '\033[46m')"  
WHITEBG="$(printf '\033[47m')" 
BLACKBG="$(printf '\033[40m')"

RESET="$(printf '\033[37m')"


check_distro() {
    distor=$(uname -a | grep -i -c "manjaro")
    if [ $distor -ne 1 ]; then
        echo -e "\n $RED 😈 Manjaro Linux Not detected $RESET  \n";exit
    fi
}

check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo  -e "\n $RED 😱 Script must be run with as root $RESET \n";exit
    fi
}


mirror_set(){
    echo -e "\n ✔ $GREEN Updating Mirror List.... $RESET \n"
    eval pacman-mirrors -g
}


update() {
    echo -e "\n ✔ $GREEN Updating system using pacman  update command.... $RESET \n"
    eval pacman -Syyu
}

install_tools() {
    echo -e "\n ✔ $GREEN Installing some tools .... $RESET \n"
    eval pacman -S gcc code chromium rofi vifm lsd go nodejs npm alacritty gdb tmux
}



setup_config() {
    echo -e "\n ✔ $GREEN Changing the Configuration .... $RESET \n"
    eval rm ~/.bashrc
    eval rm ~/.i3/config
    eval mv .bashrc  ~/.bashrc
    eval mv .i3/config ~/.i3/config
    # vim
    eval rm ~/.vimrc
    eval mv .vimrc ~/.vimrc
    # alacritty
    eval mkdir -p ~/.config/alacritty
    eval mv .alacritty.yml ~/.config/alacritty/alacritty.yml
    # rofi
    eval mkdir -p ~/.config/rofi/themes
    eval mv center.rasi ~/.config/rofi/themes/center.rasi
}


# art
asciiart=$(base64 -d <<< "ICAgICAgICAgXC4gICBcLiAgICAgIF9fLC0iLS5fXyAgICAgIC4vICAgLi8KICAgICAgIFwuICAgXGAuICBcYC4tJyIiIF8sPSI9Ll8gIiJgLS4nLyAgLicvICAgLi8KICAgICAgICBcYC4gIFxfYC0nJyAgICAgIF8sPSI9Ll8gICAgICBgYC0nXy8gIC4nLwogICAgICAgICBcIGAtJywtLl8gICBfLiAgXyw9Ij0uXyAgLF8gICBfLi0sYC0nIC8KICAgICAgXC4gL2AsLScsLS5fIiIiICBcIF8sPSI9Ll8gLyAgIiIiXy4tLGAtLCdcIC4vCiAgICAgICBcYC0nICAvICAgIGAtLl8gICIgICAgICAgIiAgXy4tJyAgICBcICBgLScvCiAgICAgICAvKSAgICggICAgICAgICBcICAgICwtLiAgICAvICAgICAgICAgKSAgIChcCiAgICAsLSciICAgICBgLS4gICAgICAgXCAgLyAgIFwgIC8gICAgICAgLi0nICAgICAiYC0sCiAgLCdfLl8gICAgICAgICBgLS5fX19fLyAvICBfICBcIFxfX19fLi0nICAgICAgICAgXy5fYCwKIC8sJyAgIGAuICAgICAgICAgICAgICAgIFxfLyBcXy8gICAgICAgICAgICAgICAgLicgICBgLFwKLycgICAgICAgKSAgICAgICAgICAgICAgICAgIF8gICAgICAgICBkZXYtZnJvZyAoICAgICAgIGBcCiAgICAgICAgLyAgIF8sLSciYC0uICAsKyt8VHx8fFR8KysuICAuLSciYC0sXyAgIFwKICAgICAgIC8gLC0nICAgICAgICBcL3xgfGB8YHwnfCd8J3xcLyAgICAgICAgYC0sIFwKICAgICAgLywnICAgICAgICAgICAgIHwgfCB8IHwgfCB8IHwgICAgICAgICAgICAgYCxcCiAgICAgLycgICAgICAgICAgICAgICBgIHwgfCB8IHwgfCAnICAgICAgICAgICAgICAgYFwKICAgICAgICAgICAgICAgICAgICAgICAgYCB8IHwgfCAnCiAgICAgICAgICAgICAgICAgICAgICAgICAgYCB8ICc=")

banner() {
    echo -e "$MAGENTA $asciiart $RESET"
    echo -e "\n$BLUE Author: dev-frog   email: froghunter.cft@gmail.com"
}

install() {
    update
    install_tools
}

banner
check_distro
check_root
mirror_set
install
