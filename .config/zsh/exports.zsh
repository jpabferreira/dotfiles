###############################################################################
#                                 ZSH EXPORTS                                 #
###############################################################################
# NOTE: Consider setting environment variables in ~/.config/pam_env.conf to
# make use of the PAM infrastructure.

# ---- PATH -------------------------------------------------------------------
# Add ~/.local/bin to the path
export PATH="${PATH}:$HOME/.local/bin"

# ---- Colors -----------------------------------------------------------------
# Set ZLSCOLORS
export ZLSCOLORS="${LS_COLORS}"

# ---- History ----------------------------------------------------------------
## ZSH History ##
export HISTSIZE=100000
export SAVEHIST=100000
export HIST_STAMPS="dd.mm.yyyy"
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE="$HOME/.cache/zsh/zsh_history"

# ---- Application-specific ---------------------------------------------------
# ls - Disable wrapping filenames containing spaces with quotes
export QUOTING_STYLE=literal

# ranger - Set the RANGER_LOAD_DEFAULT_RC to FALSE to stop ranger from loading
# both the default and the custom rc.conf in ~/.config/ranger
export RANGER_LOAD_DEFAULT_RC="FALSE"

# ripgrep - Set ripgrep config path
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/rg.conf

# hyprshot - Save directory
export HYPRSHOT_DIR=$HOME/Pictures/Screenshots
