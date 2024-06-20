# Add ~/.local/bin to the PATH
export PATH="${PATH}:${HOME}/.local/bin/"

# Set VI mode
# set -o vi

# Powerlevel10k prompt #
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
# To customize, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Or use a simpler Agnoster prompt:
# source agnoster.zsh-theme from https://github.com/romkatv/agnoster-gaps

# User-specific config
source $HOME/.config/zsh/options.zsh
source $HOME/.config/zsh/aliases.zsh
source $HOME/.config/zsh/exports.zsh
source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/plugins.zsh
source $HOME/.config/zsh/fzf.zsh
source $HOME/.config/zsh/bindings.zsh
#
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec Hyprland > ~/.hyprland.log
fi
# Last minute fixes
source $HOME/.config/zsh/overrides.zsh

