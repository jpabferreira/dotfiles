#  _____  _____ __  __   ____  __            _           
# /__  / / ___// / / /  / __ \/ /_  ______ _(_)___  _____
#   / /  \__ \/ /_/ /  / /_/ / / / / / __ `/ / __ \/ ___/
#  / /_____/ / __  /  / ____/ / /_/ / /_/ / / / / (__  ) 
# /____/____/_/ /_/  /_/   /_/\__,_/\__, /_/_/ /_/____/  
#                                  /____/                
#

## grc - Colorize a shitload of output ##
# Requires grc (https://github.com/garabik/grc)
[[ -s /etc/grc.zsh ]] && source /etc/grc.zsh <$TTY

## command-not-found handler ##
# In case of failure, informs the user which Arch package provides the command
[[ -s /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

## LS_COLORS ##
# Defines the output colors for the ls command
[[ -s ~/.local/share/lscolors.sh ]] && source ~/.local/share/lscolors.sh

# Plugins #
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh  # Zsh Autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Zsh-syntax-highlightling
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zsh-FZF
source $HOME/.config/zsh/plugins/zsh-fzf/key-bindings.zsh

# Uncomment the lines below to configure completion using the zsh-completion plugin
# fpath=($HOME/.config/zsh/plugins/zsh-completions/src $fpath)
# # Completion settings
# zstyle ':completion:*' menu yes select
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# source $HOME/.config/zsh/plugins/zsh-completions/completion-options.zsh
# autoload -Uz compinit
# compinit

# Uncomment the lines below to replace Zsh's builtin completion mechanism with fzf
# # Fzf-tab: Make fzf the deafault Zsh completion engine
# source $HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
# zstyle ':fzf-tab:*' fzf-min-height '15' # Increase min size
