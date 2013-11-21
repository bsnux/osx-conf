# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx git-flow brew fabric sublime django postgres screen)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all

# Username
USERNAME="arturo.fernandez"

# Setting PATH
export PATH=/Users/$USERNAME/.rbenv/shims:/usr/local/share/npm/bin:/usr/local/share/python:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/Users/$USERNAME/scripts/

# Front-end
alias grb='grunt build'

# Node
export NODE_PATH=/usr/local/lib/node_modules:${NODE_PATH}

# Go lang
export GOPATH=${HOME}/dev/go-workspace/

export EDITOR='vim'
