#!/bin/sh
DIRNAME="$(dirname "$0")"
#echo $DIRNAME
alias modalias='vim $DIRNAME/alias.zsh'
alias {modzshrc,modzsh}='vim ~/.zshrc'
alias modvim='vim ~/.config/nvim/init.vim'

# Jira
alias jira='$DIRNAME/Jira/userIssue.sh'
alias jirauser='function _jirauser(){ jira USER="$1" };_jirauser'
alias jiraid='function _jiraissue(){ jira ISSUE_ID="$1" };_jiraissue'

#git
alias {gs,status}="git status"
alias {gaa,addall}="git add ."
alias {gclean,clean}="git clean -fd"
alias gcma="git commit --amend"
alias {gl,glog}='function _gl(){ git log --author="$1" };_gl'
alias g2c='$DIRNAME/Git/gitCommit.sh'
alias {gp,push}='git push'
alias {gpull,pull}='git pull'
alias {gcm,commit}='function _gcm(){ git commit -m $1 };_gcm'
alias {gstash,stash}='git stash'
alias {gcheckout,checkout}='git checkout'
alias gcb='git checkout -b'
alias gc='git checkout'

#search
alias wiki='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://en.wikipedia.org/w/index.php?search=$1" };_open'
alias wikicorp='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://wiki.corp.adobe.com/dosearchsite.action?queryString=$1" };_open'
alias youtube='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://www.youtube.com/results?search_query=$1" };_open'
alias google='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://www.google.com/search?q=$1" };_open'
alias github='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://www.github.com/search?q=$1" };_open'
alias gimage='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://www.google.com/search?tbm=isch&q=$1" };_open'
alias gnews='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://news.google.com/search?q=$1" };_open'
alias duckduckgo='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://duckduckgo.com/?q=$1" };_open'
alias {imdb,movie}='function _open(){ 1=$(echo $*|sed -e "s/ /%20/g") && open "https://imdb.com/find?q=$1" };_open'
alias ssearch='duckduckgo'
alias search='google'
alias news='gnews'
alias {image,images}='gimage'
alias {video,videos}='youtube'

#common
alias untar='tar -zxvf'
alias getpass="openssl rand -base64 20"
#alias www='python2 -m SimpleHTTPServer 8000'
alias {www,startserver}='python -m http.server 8000'
alias ipe='curl ipinfo.io/ip'
alias ipi='ipconfig getifaddr en0'
alias {c,clr,cl}='clear'
alias h='history'
alias mkdir="mkdir -pv"
alias mkcd='function _mkcd(){ mkdir $1 && cd $1 };_mkcd'
alias i='tldr'

#new commands
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
alias pg="ping google.com -c 5"

#Directories
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias desk="cd ~/Desktop"
alias {cdd,doc}="cd ~/Documents"
alias down="cd ~/Downloads"

#Custom methods
source $DIRNAME/Utility/methods.sh

#app
alias vim='nvim'
#npm
alias npm-work='npm config set registry https://artifactory.corp.adobe.com'
alias npm-default='npm config set registry https://registry.npmjs.org'

#others
alias {r,reload}='source ~/.zshrc'
