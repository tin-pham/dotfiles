#!/bin/zsh

ZSH_THEME="spaceship"
# Export
export ZSH="/home/shin/.oh-my-zsh"
export EDITOR='nvim'
export VISUAL='nvim'
export JAVA_HOME='/usr/lib/jvm/java-11-openjdk-amd64/'
export MANPAGER="nvim +Man!"
export PATH=/usr/local/bin:~/.npm-global/bin:~/.local/bin:$PATH
export PROJECT="/media/shin/Extenal Storage/Coding/Project/clothes-shop"
# Fix Background Color in tmux
export TERM="xterm-256color"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # Load NVM
export PS1="[%* - %D] %d %% "
# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Misc
setopt autocd
setopt extendedglob

# Alias
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias vim='nvim'
alias v\.='nvim ./'
alias v='nvim'
alias vimdiff='nvim -d'
alias t1='tree -L 1'
alias t2='tree -L 2'
alias t3='tree -L 3'

alias k1='kill %1'
alias k2='kill %2'
alias k3='kill %3'

alias lc='colorls --sd'
alias cnv='cd ~/.config/nvim'
alias cw='cd "$PROJECT"'
alias ct='cd "/media/shin/Extenal Storage/Coding/test/"'
alias cl='cd "/media/shin/Extenal Storage/Coding/Learning2/git-course/"'
alias cu='cd ~/Desktop/College/'
alias clearswap='rm ~/.local/share/nvim/swap/*'

alias maketags='ctags -R --exclude=.git --exclude=node_modules .'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias mongod-start='mongod --config ~/.config/mongodb/mongod.cfg'

# Kitty Alias
alias icat="kitty +kitten icat"
alias vt="v ~/.config/kitty/kitty.conf"
# Flatpak
alias discord='flatpak run com.discordapp.Discord'

alias cn='cd "/media/shin/Extenal Storage/notes"'

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

