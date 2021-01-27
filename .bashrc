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
		PS1='\e[0;31m\u \e[32m\W >>\e[0m '
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
alias pss='ps -eaf --forest'
alias pst='ps -ejH'
alias myip="curl https://ipinfo.io; echo"
alias loip="/sbin/ifconfig enp2s0 | awk '/inet / {print $2}' | sed -e s/addr://"
alias open="xdg-open"
alias rm="rm -i"



# my custom alias

mc(){
  mkdir -p $1 && cd $1
}

tmpt(){
  cd $(mktemp -d)
}


# Server
alias www="python -m http.server 8000"
alias pwww="php -S 0.0.0.0:8001"


# Process 
alias ports="netstat -tulanp"
alias psmem="ps auxf | sort -nr -k 4"
alias pscpu="ps auxf | sort -nr -k 3"

# git alias
alias gs="git status"
alias gl="git log"
alias commit="git commit -a"
alias ga="git add -A"
alias gal="git add ."
alias push="git push"
alias pull="git pull"




# Develpment
alias pas='php artisan serve'


xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

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




export PATH=$PATH:~/go/bin

