#!/bin/zsh

if [ -f ~/.zsh_alias ]; then 
  source ~/.zsh_alias
fi

## ZIM
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Use git to install module
zstyle ':zim:zmodule' use 'git'
# Initialize modules.
source ${ZIM_HOME}/init.zsh

#ZSH_THEME="spaceship"
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Misc
setopt autocd
setopt extendedglob

# Correction
setopt correctall

# Prompt
# autoload -U promptinit
# promptinit
# prompt gentoo

#source $ZSH/oh-my-zsh.sh
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh

bindkey -e
bindkey '^ ' autosuggest-accept
# Autopair ZSH
# source ~/.zsh/zsh-autopair/autopair.zsh
# autopair-init


#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#export PATH=$PATH:/home/shin/.spicetify
