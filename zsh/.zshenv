alias cspell='cspell-cli'

#export ZSH=~/.oh-my-zsh
#export ZSH_CUSTOM=$ZSH/custom

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export SDL_AUDIODRIVER=dsound

#export NVM_DIR="$XDG_DATA_HOME"/nvm && source "$NVM_DIR/nvm.sh"

# Export
export HHD="/run/media/tinpham/hdd"
export ZSH="/home/shin/.oh-my-zsh"
export EDITOR='nvim'
export VISUAL='nvim'
export JAVA_HOME='/usr/lib/jvm/java-11-openjdk-amd64/'
export MANPAGER="nvim +Man!"
export PROJECT="$HHD/Coding/Project/shop-ease"
export BOOKS="$HHD/Documents/Books"

export FNM_PATH=~/.local/share/fnm
export NPM_PATH=~/.local/share/npm/bin
export YARN_PATH="$(yarn global bin)"
export NVIM_PATH=/opt/nvim-linux64/bin
export ISTIO_PATH=~/bin/istio-1.23.0/bin
export HOME_BIN=~/bin
export MASON_PATH="$HOME/.local/share/nvim/mason/bin"
export PATH="/usr/local/bin:$HOME/.local/bin:$HOME_BIN:$FNM_PATH:$NPM_PATH:$YARN_PATH:$NVIM_PATH:$ISTIO_PATH:$MASON_PATH:$PATH"

export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'
# Fix Background Color in tmux
export TERM="xterm-256color"
export PS1="[%* - %D] %d %% "
# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE

export GLFW_IM_MODULE=ibus

export ZIM_HOME="${XDG_DATA_HOME}/zim"

export TERMINFO='/usr/share/terminfo/'

export OPENMW_MODS="$HHD/LutrisGame/gog/the-elder-scrolls-iii-morrowind-goty-edition/mods"
export OPENMW_CONFIGS="$HOME/.config/openmw"
export OPENMW_GAME="$HHD/LutrisGame/gog/the-elder-scrolls-iii-morrowind-goty-edition/game"


# Ibus
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus

export OPENAI_API_KEY=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
export AVANTE_GEMINI_API_KEY="AIzaSyCIyaf8fflt-dQQ_5lG4nNzbMMCTdDAz24"
export ESLINT_USE_FLAT_CONFIG=true
