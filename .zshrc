ALEXDOT=$HOME/.alexdot
# Path to your oh-my-zsh configuration.

export ZSH=$ALEXDOT/oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="alspar"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# sources
source $ALEXDOT/aliases.sh
source $ALEXDOT/exports.sh
source $ALEXDOT/z/z.sh
function precmd () {
          z --add "$(pwd -P)"
}
