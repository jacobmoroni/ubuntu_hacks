# Path to your oh-my-zsh installation.
export ZSH="/home/jacobolson/.oh-my-zsh"
 
ZSH_THEME="af-magic"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
# Alias
source ~/projects/ubuntu_hacks/dotfiles/.aliases

#Ardupilot Workspace Sourcing
export PATH=$PATH:$HOME/projects/ardupilot-fortem/Tools/autotest
export PATH=/usr/lib/ccache:$PATH

# This enables custom commands in terminator
echo $INIT_CMD
if [ ! -z "$INIT_CMD" ]; then
    OLD_IFS=$IFS
    setopt shwordsplit
    IFS=';'
    for cmd in $INIT_CMD; do
        print -s "$cmd"  # add to history
        eval $cmd
    done
    unset INIT_CMD
    IFS=$OLD_IFS
fi
stty -ixon


source /opt/ros/jazzy/setup.zsh

eval "$(register-python-argcomplete ros2)"
eval "$(register-python-argcomplete colcon)"

# Java
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
# This sets commands so that there is no error if nothing is returned. Example ls *.tgz will fail silently if there is no tgz file
setopt nonomatch

# Pyenv Setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:${PATH}"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ROS Sourcing
source ~/projects/ubuntu_hacks/dotfiles/.rosrc

# Helper script sourcing
source ~/projects/ubuntu_hacks/helper_scripts
