#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|
# Aliases for a few useful commands

alias mirrorUpdate='reflector --country us --latest 15 --protocol https --sort rate --save /etc/pacman.d/mirrorlist --verbose'
alias pacmanGhost='~/.scripts/pacman.sh'
alias shivita='toilet -f mono12 -F rainbow 'andrea' | ponythink -f winona'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias ll='ls -la'
alias lt='lsd --tree'
alias cp="cp -i"
alias df="df -h"
alias free="free -m"
alias pss="ps -eaf --forest"
alias pst="ps -ejH"
alias ports="netstat -tulanp"
alias psmem="ps auxf | sort -nr -k 4"
alias pscpu="ps auxf | sort -nr -k 3"
alias myip="curl https://ipinfo.io; echo"
alias loip="/sbin/ifconfig enp2s0 | awk '/inet / {print $2}' | sed -e s/addr://"
alias open="xdg-open"
alias ymp3="youtube-dl -i --extract-audio --audio-format mp3 --audio-quality 0"
alias codeext="code --install-extension"
alias sysinfo="inxi --admin --verbosity=7 --filter --no-host --width"
alias dc="cd"
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias install="sudo pacman -S"
alias ss="sudo systemctl"
alias jctl="journalctl -p 3 -xb"
alias x='ranger'
alias h='htop'
alias em="/usr/bin/emacs -nw"
alias mkdir="mkdir -pv"
alias reload="source ~/.zshrc"
alias install="sudo pacman -S"
alias __="sudo !!"
alias pk="pkill -9"
alias gz="tar -zcvf"
alias dl="cd ~/Downloads"
alias office="cd ~/code/__offices"
alias week='date +%V'
alias t="tmux"
alias c="cmatrix"

# developer 
alias www="python -m http.server 8000"
alias pwww="php -S 0.0.0.0:8001"
alias venv="python -m venv venv"
alias pas='php artisan serve'



# Change shell
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"



# Github
alias gitpass="git config user.auth | xclip -selection c"
alias gst="git status"
alias ga="git add"
alias gaa="git add ."
alias gau="git add -U"
alias gc="git commit -m"
alias gca="git commit -a"
alias gb="git branch"
alias gbd="git branch -d"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gt="git stash"
alias gta="git stash apply"
alias gm="git merge"
alias gr="git rebase"
alias gitbranchs="git for-each-ref --sort=-committerdate --format='%(HEAD) %(refname:short)'"
alias gitlog='git log --graph --decorate --all --full-history --date=short --pretty=format:"%h%x20Cgreen%d%x20%Cred%an%x20%Cblue%x20%Creset%s"'
alias gshow="git show"
alias gd="git diff HEAD"
alias push="git push origin"
alias pull="git pull origin"


# Devlopment
alias nextjs="yarn create next-app"
alias expressapi="npx c2-api"
alias reactjs="npx create-react-app"


# Nodejs and npm
alias nb="npm run build"
alias nis="npm i --save"
alias nid="npm i --save-dev"
alias ng="sudo npm -g i"
alias nd="npm run dev"
alias ns="npm start"

alias junk='ncdu -x /'

## Security 

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

## All my function
mc() {
 mkdir $1 && cd $_
}

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

tmpt(){
  cd $(mktemp -d)
}


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

# Tmux setup

ide() {
  tmux split-window -v -p 30
  tmux split-window -h -p 66
  tmux split-window -h -p 50
}


# Searches for text in all files in the current folder
ftext ()
{
	grep -iIHrn --color=always "$1" . | less -r
}


alias tb="nc termbin.com 9999"

io(){
  curl -F 'f:1=<-' ix.io
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




setopt COMPLETE_ALIASES
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt appendhistory
setopt autocd
setopt extendedglob
setopt incappendhistory
setopt nomatch
setopt notify
setopt sharehistory

unsetopt beep
bindkey -e
autoload -Uz compinit promptinit bashcompinit
compinit
promptinit
bashcompinit
zstyle :compinstall filename '$HOME/.zshrc'
complete -o nospace -C /usr/bin/vault vault
complete -o nospace -C /usr/bin/terraform terraform

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
    colorize
    copyfile
    docker
    docker-compose
    emacs
    git
    gitfast
    golang
    history-substring-search
    kubectl
    rust
    safe-paste
    tmux
    virtualenv
)

# Source Oh My ZSH for plugins and zsh-autosuggestions, zsh-syntax-highlighting,
# zsh-history-substring-search and the powerlevel10k theme.
while IFS= read -r script
do
    source "$script"
done < <(find /usr/share/zsh/plugins/ -maxdepth 2 -type f -name "*.zsh" ! -name '*plugin.zsh')
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:~/go/bin
eval "$(zoxide init zsh)"
