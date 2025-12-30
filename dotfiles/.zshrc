# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/jacobolson/.oh-my-zsh"
 
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
source ~/.aliases

#Ardupilot Workspace Sourcing
export PATH=$PATH:$HOME/workspaces/ardupilot-fortem/Tools/autotest
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

# To get conan tests to work, anansi_ros install dir has to be hidden. I hide it in a directory called hideout
anansi_ros_dir=/home/jacobolson/projects/dronehunter-dev/src/production/anansi_ros
if [[ ! -d "$anansi_ros_dir/install" ]]; then
  anansi_ros_dir="$anansi_ros_dir/hideout"
fi
source $anansi_ros_dir/install/setup.zsh --extend

eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

source $(ros2 pkg prefix anansi_start)/lib/anansi_start/scripts/dh_aliases.sh
export ANANSI_BUILD_JOBS=6
# This will 
#export ROS_DOMAIN_ID=13
export ROS_LOCALHOST_ONLY=1

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin
# This sets commands so that there is no error if nothing is returned. Example ls *.tgz will fail silently if there is no tgz file
setopt nonomatch

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:${PATH}"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
