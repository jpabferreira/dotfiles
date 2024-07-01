###############################################################################
#                                  FZF CONFIG                                 #
###############################################################################
# ---- Environment Variables --------------------------------------------------
# Default command for FZF
export FZF_DEFAULT_COMMAND="fd"

# Find home files/directories with Ctrl+T
export FZF_CTRL_T_COMMAND="fd . $HOME"
# Ctrl+T options
export FZF_CTRL_T_OPTS="--preview='$HOME/.config/fzf/preview.sh {}'"

# Find home directories with Alt+C
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
# Alt+C options
export FZF_ALT_C_OPTS="--preview='lsd --icon=always --color=always --tree --depth 1 {}'"

# Ctrl+R (history search) options
export FZF_CTRL_R_OPTS=""

# Default FZF Config
export FZF_DEFAULT_OPTS="
-i
--ansi
--border=horizontal
--border-label-pos=top
--color=16
--color=border:7
--color=marker:green
--color=prompt:yellow
--color=current-bg:237
--layout=reverse
--header-first
--info=inline-right
--height=90%
--margin=0%
--preview=''
--prompt='󱎸  '
--pointer='󰁚 '
--marker='󰄵 '
--bind='?:toggle-preview'
--bind='ctrl-a:select-all'
--bind='ctrl-e:execute(nvim {+} >/dev/tty)'
--bind='ctrl-u:preview-page-up'
--bind='ctrl-d:preview-page-down'"

# ---- Aliases-----------------------------------------------------------------
# FZF with directory/file previewer for multiple mime-types
alias fzp="fzf --preview='$HOME/.config/fzf/preview.sh {}'"

# ---- Functions --------------------------------------------------------------
# cfile - Use FZF to select a config file for edition
cfile() {
  edfile=""
  if (( $# > 0 ))
	then
    edfile=$(find ~/.config -type f | fzf -q "$@" --preview='$HOME/.config/fzf/preview.sh {}')
  else
    edfile=$(find ~/.config -type f | fzf --preview='$HOME/.config/fzf/preview.sh {}')
  fi

  if [ -f $edfile ] && [[ $edfile != "" ]] ; then
    nvim $edfile
  fi
}

# cdir - Change to a config directory selected witg FZF
cdir() {
  cddir=""
  if (( $# > 0 ))
	then
    cddir=$(find ~/.config -maxdepth 1 -type d | fzf -q "$@" --preview='lsd --tree --icon=always --color=always --depth 2 {}')
  else
    cddir=$(find ~/.config -maxdepth 1 -type d | fzf --preview='lsd --tree --icon=always --color=always --depth 2 {}')
  fi

  if [ -d $cddir ] && [[ $cddir != "" ]] ; then
    cd $cddir
  fi
}
