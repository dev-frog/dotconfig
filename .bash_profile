#
# ~/.bash_profile
#


function banner() {
    echo "         _               _             "   
    echo "        | |             | |            " 
    echo " __ _|_ | |     ,   __  | |       _   ,_  " 
    echo "/    |  |/-----/ \_/  \_|/  |  |_|/  /  |   "
    echo "\___/|_/|__/    \/ \__/ |__/ \/  |__/   |_/ "
    echo "        |\                                 "
    echo "        |/      "
    echo ""
   
}

function aumap(){
   nmap -sV -sC -oN std $IP -vvv
}

function nmap_all(){
    nmap -sV -sC -oN nmap_all_port $IP 
}

function nmap_smb(){
    nmap --script smb-enum-users -p445 $IP -oN nmap_smb_enum_users
}

function nmap_vuln(){
    nmap --script vuln -sV -T4 -oN nmap_vuln_scan $IP
}


function http_header(){
    curl --head --silent https://$IP
}

function dirScan(){
    gobuster dir -u http://$IP/ -w ~/opt/wordlist/custom_list.txt -o gobuser_scan -x .php,.html,.js,.txt
}

function fuzz(){
    wfuzz -c -z file,~/opt/wordlist/fuzz.txt --hc 400,404,403 $1
}


[[ -f ~/.bashrc ]] && . ~/.bashrc
