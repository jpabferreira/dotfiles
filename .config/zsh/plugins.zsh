###############################################################################
#                                 ZSH OPTIONS                                 #
###############################################################################
# grc - Colorize a shitload of output (requires grc: https://github.com/garabik/grc)
[[ -s /etc/grc.zsh ]] && source /etc/grc.zsh <$TTY

# command-not-found - In case of failure, informs the user which Arch package provides the command
[[ -s /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# LS_COLORS - Defines the output colors for the ls command
[[ -s ~/.local/share/lscolors.sh ]] && source ~/.local/share/lscolors.sh

# zsh-autosuggestions - Fish-like autosuggestions for Zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# zsh-syntax-highlightling - Highlight syntax of Zsh commands
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zsh-FZF - Integrate fzf with Zsh. Provides Ctrl+R, Ctrl+T, Alt+C
source $HOME/.config/zsh/plugins/zsh-fzf/key-bindings.zsh

# Uncomment the lines below to replace Zsh's builtin completion mechanism with fzf
# # Fzf-tab: Make fzf the deafault Zsh completion engine
# source $HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
# zstyle ':fzf-tab:*' fzf-min-height '15' # Increase min size
