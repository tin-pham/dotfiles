#!/bin/zsh

if [ -f ~/.zsh_alias ]; then 
  source ~/.zsh_alias
fi


ZSH_THEME="spaceship"
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Misc
setopt autocd
setopt extendedglob


source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh

bindkey -e
bindkey '^ ' autosuggest-accept
# Autopair ZSH
source ~/.zsh/zsh-autopair/autopair.zsh
autopair-init


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH=$PATH:/home/shin/.spicetify
