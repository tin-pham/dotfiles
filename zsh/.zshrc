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

# source /usr/share/bash-completion/completions/fzf
# source /usr/share/fzf/key-bindings.zsh

setopt hist_ignore_all_dups
setopt hist_ignore_space

# Misc
setopt autocd
setopt extendedglob

# Correction
setopt correctall

backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

bindkey -e
bindkey '^ ' autosuggest-accept

neofetch


# Load Angular CLI autocompletion.
source <(ng completion script)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

