# Set VI mode
# set -o vi
#
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme

#
# Powerlevel10k prompt #
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
#
# User-specific stuff
source /home/joao/.config/zsh/options.zsh
source /home/joao/.config/zsh/aliases.zsh
source /home/joao/.config/zsh/exports.zsh
source /home/joao/.config/zsh/functions.zsh
source /home/joao/.config/zsh/plugins.zsh
source /home/joao/.config/zsh/fzf.zsh
source /home/joao/.config/zsh/bindings.zsh
#
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec Hyprland > ~/.hyprland.log
fi
# Last minute fixes
source /home/joao/.config/zsh/overrides.zsh

