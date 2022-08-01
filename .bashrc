#
# ~/.bashrc
#

[[ $- != *i* ]] && return



# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red="\e[0;31m"         # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\]\[\033[01;37m\]\W\[\033[01;32m\] λ \[\033[00m\]'
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias ls='lsd'
alias l='ls -l'
alias la='lsd -a'
alias ll='ls -lah'
alias disk='df -h'
alias trash='trash-list'
alias sysinfo="inxi --admin --verbosity=7 --filter --no-host --width"

alias fm6000='fm6000 -n -c magenta -r'
fm6000


# Process 
alias pss='ps -eaf --forest'
alias pst='ps -ejH'
alias ports="netstat -tulanp"
alias psmem="ps auxf | sort -nr -k 4"
alias pscpu="ps auxf | sort -nr -k 3"


alias myip="curl https://ipinfo.io; echo"
alias loip="/sbin/ifconfig enp2s0 | awk '/inet / {print $2}' | sed -e s/addr://"
alias open="xdg-open"
alias song="mocp"

alias gpu="sudo radeon-profile"

# Social site
alias ymp3="youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0"

# vscode extension
alias codeext="code --install-extension"


alias dc="cd"
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
#navigation
up() {
    local d=""
    local limit="$1"

    if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
        limit=1
    fi
    for ((i=1; i<=limit;i++));do
        d="../$d"
    done

    if ! cd "$d"; then
        echo "Couldn't go up $limit dir.";
    fi
}

alias code.="code ."
alias code,="code ."
alias t="tmux"
# my custom alias

wlan() {
  nmcli connection modify "Wired connection 1"  ipv4.addresses 10.167.28.112/24 gw4 10.167.28.1
  nmcli connection modify "Wired connection 1" ipv4.dns 123.200.0.254
  nmcli connection modify "Wired connection 1" ipv4.method manual
  nmcli connection down "Wired connection 1"; nmcli connection up "Wired connection 1";
  nmcli connection
}

alias mining="sudo /home/frog/Duno_Coin/AVR_Miner.py"

dhcp() {
  nmcli connection modify "Wired connection 1" ipv4.addresses 192.168.1.50/24 gw4 192.168.1.1
  nmcli connection modify "Wired connection 1" ipv4.dns 1.1.1.1
  nmcli connection modify "Wired connection 1" ipv4.method auto
  nmcli connection down "Wired connection 1"; nmcli connection up "Wired connection 1";
  nmcli connection
}

mc(){
  mkdir -p $1 && cd $_
}

tmpt(){
  cd $(mktemp -d)
}

# alacitty
alc() {
    pycritty  --size $1 --opacity $2
}

# system command
alias install="sudo pacman -S"
alias __="sudo systemctl "
alias jctl="journalctl -p 3 -xb"

# Server
alias www="python -m http.server 8000"
alias pwww="php -S 0.0.0.0:8001"


alias license="npx license"

# git alias
alias gst="git status"
alias glog="git log"
alias commit="git commit -a"
alias gaup="git add -U"
alias gad="git add ."
alias push="git push origin"
alias pull="git pull origin"
alias gb="git branch"
alias gc="git checkout"
alias gcb="git checkout -b"
alias glol="git log --oneline"

# git .gitconfig
alias gitpass="git config user.auth | xclip -selection c"

gitignore () {
  curl https://www.toptal.com/developers/gitignore/api/visualstudiocode,$1 > .gitignore 
}


#python
alias venv="python -m venv venv"


# Nodejs and npm
alias nb="npm run build"
alias nis="npm i --save"
alias nid="npm i --save-dev"
alias ng="sudo npm -g i"
alias nd="npm run dev"
alias ns="npm start"
alias ni="npm i"

# Yarn
alias ydev="yarn dev"
alias ybuild="yarn build"
alias ystart="yarn build"

# NextJS
alias nextjs="npx create-next-app"
alias react="npx create-react-app"

## Note
alias _nfastapi="vim __Note/fastapiNote.md"
alias nf="neofetch"


#get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# switch between  shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

alias em="/usr/bin/emacs -nw"


# Develpment
alias pas='php artisan serve'



# Clean all temp file
alias CS='ncdu -x /'

xhost +local:root > /dev/null 2>&1
complete -cf sudo
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend
# export BROWSER=chromium
# export browser=chromium
#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


transfer() { 
	if [ $# -eq 0 ]; then 
	echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; 
	return 1; 
	fi; 
	tmpfile=$( mktemp -t transferXXX ); 
	if tty -s; 
	then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); 
	curl --progress-bar --upload-file "$1" "https://free.keep.sh/$basefile" >> $tmpfile; 
	else curl --progress-bar --upload-file "-" "https://free.keep.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; 
}

alias tb="nc termbin.com 9999"


imgur() {
    curl -F key="5zAp2KhxBTD3a5AmnjN+p86cxm4+m86f" -F file="$1" https://imagebin.ca/upload.php
}


# Programming function

cbt(){
	curl -L "https://raw.githubusercontent.com/dev-frog/templates/main/C_temp.c" -o $1.c
}

cpp(){
	curl -L "https://raw.githubusercontent.com/dev-frog/templates/main/C%2B%2B_temp.cpp" -o $1.cpp
}

py(){
	curl -L "https://raw.githubusercontent.com/dev-frog/templates/main/Py_temp.py" -o $1.py
}

pwnt(){
	curl -L "https://raw.githubusercontent.com/dev-frog/templates/main/exploit.py" -o exploit_$1.py
}

io(){
  curl -F 'f:1=<-' ix.io
}


export PATH=$PATH:~/go/bin


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

eval "$(starship init bash)"
