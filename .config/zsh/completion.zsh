###############################################################################
#                                ZSH COMPLETION                               #
###############################################################################
# See:
# https://github.com/Phantas0s/.dotfiles/blob/master/zsh/completion.zsh
# https://thevaluable.dev/zsh-completion-guide-examples/

# ---- Modules ----------------------------------------------------------------
# Load the complist module
zmodload zsh/complist

# ---- Custom Keys ------------------------------------------------------------
# Press ESC to cancel completion and erase completion text
# bindkey -M menuselect '\e' send-break
bindkey -M menuselect '^[' undo

# ---- Completion Sources -----------------------------------------------------
# fpath=($HOME/.config/zsh/plugins/zsh-completions/src $fpath)
# fpath=($HOME/.config/zsh/plugins/zsh-more-completions/src $fpath)
# Use my own (huge) set of completion sources (made of zsh-completions + zsh-more-completions)
fpath=($HOME/.config/zsh/completion-sources $fpath)

# ---- Compinit ---------------------------------------------------------------
autoload -Uz compinit
compinit -d $HOME/.cache/zsh/zcompdump

# ---- Options ----------------------------------------------------------------
# Completion options
# setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# ---- Zstyles (completion config) --------------------------------------------
# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _expand_alias _complete _approximate

# Use cache 
zstyle ':completion:*' use-cache on
# Cache path
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Alias completion. Complete aliases when _expand_alias is used as a function
zstyle ':completion:*' complete true
zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Enable menu selection
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

# Descriptions for each set of completion items
zstyle ':completion:*:*:*:*:corrections' format '%B%F{yellow}%S  %d (errors: %e)%s%f%b'
zstyle ':completion:*:*:*:*:descriptions' format '%B%F{blue}󰨾  %d%f%b%b'
zstyle ':completion:*:*:*:*:messages' format '%B%F{purple}%S󰍪  %d%s%f%b'
zstyle ':completion:*:*:*:*:warnings' format '%B%F{red}%S  No matches found%s%f%b'

# Colors for files, directories and selector block (ma=)
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS} "ma=48;5;3;38;5;0"
# Color command options
zstyle ':completion:*:options' list-colors '=(#b)(-[^ -]#)#( [^-]*)=0=0=33'

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Enable case insensitive completion
# - See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

