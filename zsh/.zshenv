alias cspell='cspell-cli'

export ZSH=~/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export SDL_AUDIODRIVER=dsound

export NVM_DIR="$XDG_DATA_HOME"/nvm && source "$NVM_DIR/nvm.sh"

# Export
export HDD="/media/shin/hdd"
export ZSH="/home/shin/.oh-my-zsh"
export EDITOR='nvim'
export VISUAL='nvim'
export JAVA_HOME='/usr/lib/jvm/java-11-openjdk-amd64/'
export MANPAGER="nvim +Man!"
export PATH=/usr/local/bin:~/.npm-global/bin:~/.local/bin:~/bin:$PATH 
export PROJECT="$HDD/Coding/Project/clothes-shop"

export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'
# Fix Background Color in tmux
export TERM="xterm-256color"
export PS1="[%* - %D] %d %% "
# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE

export GLFW_IM_MODULE=ibus
