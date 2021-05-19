#custom source
source ~/.secrets
#
#setup
#configure emsdk Paths
#CURRPATH=${$(pwd)}
#cd ~/Documents/CCWeb/CoeditingExperiments/third_party/emsdk/ && source emsdk_env.sh
#cd $CURRPATH

#python 3
export PYENV_ROOT="$HOME/.pyenv" # adjust if you chose someplace different for a git-based install
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi
if which pyenv-virtualenv-init > /dev/null; then
 eval "$(pyenv virtualenv-init -)";
fi

#Photoshop
export PS_SETUP_PRODUCTS=photoshop
