#  _____  _____ __  __   ______                      __      
# /__  / / ___// / / /  / ____/  ______  ____  _____/ /______
#   / /  \__ \/ /_/ /  / __/ | |/_/ __ \/ __ \/ ___/ __/ ___/
#  / /_____/ / __  /  / /____>  </ /_/ / /_/ / /  / /_(__  ) 
# /____/____/_/ /_/  /_____/_/|_/ .___/\____/_/   \__/____/  
#                              /_/                           
# NOTE: Consider setting environment variables in ~/.config/pam_env.conf to
# make use of the PAM infrastructure.

export PATH="${PATH}:$HOME/.local/bin"

################################
#  /\  _  _ |. _ _ |_. _  _  _ #
# /--\|_)|_)||(_(_||_|(_)| )_) #
#     |  |                     #
################################

## ZSH History ##
export HISTSIZE=100000
export SAVEHIST=100000
export HIST_STAMPS="dd.mm.yyyy"
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE="$HOME/.cache/zsh/zsh_history"

## ranger ##
# Set the environment variable RANGER_LOAD_DEFAULT_RC to FALSE to stop
# ranger from loading both the default and the custom rc.conf in
# ~/.config/ranger
export RANGER_LOAD_DEFAULT_RC="FALSE"

## Ripgrep ##
# Set ripgrep config path
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/rg.conf

## Other ##
# Disable wrapping filenames containing spaces with quotes
export QUOTING_STYLE=literal

# Hyprshot save directory
export HYPRSHOT_DIR=$HOME/Pictures/Screenshots
